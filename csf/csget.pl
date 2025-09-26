#!/usr/bin/perl
###############################################################################
# Copyright (C) 2025 Sentinel Project (https://github.com/sentinelfirewall/sentinel)
# Copyright (C) 2006-2025 Jonathan Michaelson (https://github.com/waytotheweb/scripts)
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses>.
###############################################################################

use strict;
use warnings;
use diagnostics;

# Daemonize
if (my $pid = fork) {
    exit 0;
} elsif (defined($pid)) {
    $pid = $$;
} else {
    die "Error: Unable to fork: $!";
}
chdir("/");
close(STDIN);
close(STDOUT);
close(STDERR);
open STDIN,  "<", "/dev/null";
open STDOUT, ">", "/dev/null";
open STDERR, ">", "/dev/null";

$0 = "Sentinel Version Check";

# Single download server
my $downloadserver = "https://raw.githubusercontent.com/stefanpejcic/sentinelfw/refs/heads/main/";

# Single version file to check
my $version_file = "/csf/version.txt";
my $local_file   = "/var/lib/configserver/csf.txt";

# Prepare local directory
system("mkdir -p /var/lib/configserver/");
unlink $local_file;
unlink $local_file . ".error" if -e $local_file . ".error";

# Determine download command
my $cmd;
if (-e "/usr/bin/curl") {
    $cmd = "/usr/bin/curl -skLf -m 120 -o";
} elsif (-e "/usr/bin/wget") {
    $cmd = "/usr/bin/wget -q -T 120 -O";
} else {
    open(my $ERROR, ">", "/var/lib/configserver/error");
    print $ERROR "Cannot find /usr/bin/curl or /usr/bin/wget to retrieve product versions\n";
    close($ERROR);
    exit;
}

# Optional GET command
my $GET = (-e "/usr/bin/GET") ? "/usr/bin/GET -sd -t 120" : "";

# Random sleep unless --nosleep
unless ($ARGV[0] eq "--nosleep") {
    system("sleep", int(rand(60 * 60 * 6)));
}

# Fetch version
unless (-e $local_file) {
    unlink $local_file . ".error" if -e $local_file . ".error";

    my $status = system("$cmd $local_file $downloadserver$version_file");
    if ($status) {
        if ($GET ne "") {
            open(my $ERROR, ">", $local_file . ".error");
            print $ERROR "$downloadserver$version_file - ";
            close($ERROR);
            system("$GET $downloadserver$version_file >> $local_file.error");
        } else {
            open(my $ERROR, ">", $local_file . ".error");
            print $ERROR "Failed to retrieve latest version from Github\n";
            close($ERROR);
        }
    }
}
