#!/bin/sh
###############################################################################
# Copyright 2009-2019, Way to the Web Limited
# URL: http://www.configserver.com
# Email: sales@waytotheweb.com
###############################################################################
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

if [ -e "/usr/local/cpanel/version" ]; then

    echo "Running cmq cPanel uninstaller"
	echo

    if [ -e "/usr/local/cpanel/bin/unregister_appconfig" ]; then
        cd /
        /usr/local/cpanel/bin/unregister_appconfig cmq
    else
        if [ ! -e "/var/cpanel/apps/cmq.conf" ]; then
            /bin/rm -fv /var/cpanel/apps/cmq.conf
        fi
    fi

    /bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/addon_cmq.cgi
    /bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/cmqversion.txt
    /bin/rm -Rfv /usr/local/cpanel/whostmgr/docroot/cgi/cmq

    /bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmq.cgi
    /bin/rm -fv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmqversion.txt
    /bin/rm -Rfv /usr/local/cpanel/whostmgr/docroot/cgi/configserver/cmq

elif [ -e "/usr/local/directadmin/directadmin" ]; then

    echo "Running cmq DirectAdmin uninstaller"
	echo

    /bin/rm -Rfv /usr/local/directadmin/plugins/cmq

fi

/bin/rm -Rfv /etc/cmq

echo "ConfigServer Mail Queues has been uninstalled."
exit
