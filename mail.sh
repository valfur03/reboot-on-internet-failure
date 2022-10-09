#!/bin/sh

set -eu

source $(dirname $0)/variables.sh

if [ -f /root/.send-mail-on-next-reboot ]
then
	# Waiting for network connection
	i=0
	while [ $i -lt $MAX_WAIT_TIME ] && ! ping -c 1 $PING_DOMAIN > /dev/null 2>&1
	do
		i=$(($i + 1))
		sleep 1
	done

	# Sending a mail with msmtp
	msmtp $EMAIL_ADDRESS <<EOF
From: $EMAIL_SENDER <$EMAIL_ADDRESS>
Subject: The system has reboot because of an internet failure

$(journalctl -b -1)
EOF
	rm /root/.send-mail-on-next-reboot
fi
