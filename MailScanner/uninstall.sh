#!/bin/sh
###############################################################################
# Copyright 2004-2020, Way to the Web Limited
# URL: http://www.configserver.com
# Email: sales@waytotheweb.com
###############################################################################
PATH=$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

if [ ! -e "msinstall.pl" ]; then
	echo "You must be inside the msinstall directory to run this script"
    exit
fi

if [ -e "/usr/local/cpanel/version" ]; then
    sed -i 's%/usr/bin/perl%/usr/local/cpanel/3rdparty/bin/perl%' msuninstall.pl
else
    sed -i 's%/usr/local/cpanel/3rdparty/bin/perl%/usr/bin/perl%' msuninstall.pl
fi

if [ -e "/usr/msfe/uninstall.msfe.sh" ]; then
    sh /usr/msfe/uninstall.msfe.sh
fi

rm -Rfv /usr/msfe
rm -f /etc/cron.daily/mailscanner_daily.cron

if test `cat /proc/1/comm` = "systemd"
then
    systemctl disable MailScanner.service
    systemctl stop MailScanner.service

    rm -f /usr/lib/systemd/system/MailScanner.service
    systemctl daemon-reload
else
    service MailScanner stop
    chkconfig MailScanner off
    chkconfig MailScanner --del
    rm -f /etc/init.d/MailScanner
fi

if [ -e "/usr/local/cpanel/version" ]; then
    rm -f /etc/chkservd.d/mailscanner
    rm -f /var/run/chkservd/mailscanner
fi

chmod +x msuninstall.pl
./msuninstall.pl 3

echo
echo "All done."
