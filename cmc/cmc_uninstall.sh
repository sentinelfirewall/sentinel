#!/bin/bash
###############################################################################
# Copyright 2006-2017, Way to the Web Limited
# URL: http://www.configserver.com
# Email: sales@waytotheweb.com
###############################################################################

if [ -e "/usr/local/cpanel/bin/unregister_appconfig" ]; then
    cd /
    /usr/local/cpanel/bin/unregister_appconfig cmc
else
    if [ ! -e "/var/cpanel/apps/cmc.conf" ]; then
        /bin/rm -fv /var/cpanel/apps/cmc.conf
    fi
fi

/bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/addon_cmc.cgi
/bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/cmcversion.txt
/bin/rm -Rfv /usr/local/cpanel/whostmgr/docroot/cgi/cmc

/bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmc.cgi
/bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmcversion.txt
/bin/rm -Rfv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmc

echo "ConfigServer Mod Security has been uninstalled."
exit
