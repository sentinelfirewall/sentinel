#!/bin/sh
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

echo
echo "Selecting installer..."
echo

declare -A installers=(
    ["/usr/local/cpanel/version"]="csf Cpanel"
    ["/usr/local/directadmin/directadmin"]="csf DirectAdmin"
    ["/usr/local/interworx"]="csf InterWorx"
    ["/usr/local/cwpsrv"]="csf CentOS Web Panel"
    ["/usr/local/vesta"]="csf VestaCP"
    ["/usr/local/CyberCP"]="csf CyberPanel"
)

for path in "${!installers[@]}"; do
    if [ -e "$path" ]; then
        cp_name="${installers[$path]}"
        echo "Running $cp_name installer"
		echo
        sh "install.${cp_name// /}.sh"
        exit 0
    fi
done

echo "Running csf generic installer"
echo
sh install.generic.sh
