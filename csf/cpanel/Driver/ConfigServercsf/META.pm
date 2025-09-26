package Cpanel::Config::ConfigObj::Driver::Sentinelcsf::META;

use strict;

our $VERSION = 1.1;

#use parent qw(Cpanel::Config::ConfigObj::Interface::Config::Version::v1);
sub spec_version {
	return 1;
}

sub meta_version {
    return 1;
}

sub get_driver_name {
    return 'Sentinelcsf_driver';
}

sub content {
    my ($locale_handle) = @_;

    my $content = {
        'vendor' => 'Stefan Pejcic',
        'url'    => 'github.com/sentinelfirewall/sentinel/',
        'name'   => {
            'short'  => 'Sentinelcsf Driver',
            'long'   => 'Sentinelcsf Driver',
            'driver' => get_driver_name(),
        },
        'since'    => 'cPanel 11.38.1',
        'abstract' => "A Sentinelcsf driver",
        'version'  => $VERSION,
    };

    if ($locale_handle) {
        $content->{'abstract'} = $locale_handle->maketext("Sentinel csf driver");
    }

    return $content;
}

sub showcase {
    return;
}
1;
