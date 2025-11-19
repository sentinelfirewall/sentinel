#!/bin/bash

set -e

echo "Starting upgrade from CSF to Sentinel..."
# https://sentinelfirewall.org/docs/upgrade-from-csf/

# 1. changes links from download.configserver.com to github, but keeps the perl ConfigServer
echo "Downloading transitional upgrade script..."
wget -q -O /etc/csf/csf.pl \
  https://gist.githubusercontent.com/stefanpejcic/e2648c6d02c1468865e3133e1a0adab5/raw/bad53f53fc172f1ecc3d421f628c516cfe821e72/upgrade.csf.pl

# 2. install from github
echo "Running csf -uf ..."
csf -uf

# 3. replaces perl ConfigServer with Sentinel
echo "Downloading Sentinel csf.pl..."
wget -q -O /etc/csf/csf.pl \
  https://raw.githubusercontent.com/sentinelfirewall/sentinel/refs/heads/main/csf/csf.pl

# 4. cpanel compatibility fix
if [ -e "/usr/local/cpanel/version" ]; then
    echo "Applying cPanel compatibility fix..."
    # https://github.com/sentinelfirewall/sentinel/issues/9
    if [ -e "/usr/local/cpanel/Cpanel/Config/ConfigObj/Driver/ConfigServercsf/META.pm" ]; then
        mv /usr/local/cpanel/Cpanel/Config/ConfigObj/Driver/ConfigServercsf/META.pm \
           /usr/local/cpanel/Cpanel/Config/ConfigObj/Driver/ConfigServercsf/META
    fi
fi

# 4. Check CSF/Sentinel version
echo -n "Checking csf version... "
CSFVER=$(csf -v 2>/dev/null | awk '{print $NF}')

echo "$CSFVER"

# 4. success?
REQUIRED_VER="15.11"

version_ge() {
    printf '%s\n%s' "$1" "$2" | sort -V -C
}

if version_ge "$CSFVER" "$REQUIRED_VER"; then
    echo "✔ Upgrade successful! Sentinel version $CSFVER installed."
    exit 0
else
    echo "✖ Upgrade may have failed: version is $CSFVER (expected $REQUIRED_VER or higher)."
    echo
    echo "Pelase report issues on https://github.com/sentinelfirewall/sentinel/issues/"
    exit 1
fi
