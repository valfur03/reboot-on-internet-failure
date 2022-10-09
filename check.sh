#!/bin/sh
# 
# Reboot on internet failure
# Run as root

set -eu

source $(dirname $0)/variables.sh

# Checking domain name resolution
if ! ping -c 1 $PING_DOMAIN > /dev/null 2>&1
then
	systemd-cat -t internet-failure-check -p emerg <<EOF
Domain name resolution failure detected!
EOF

	# Checking internet
	if ! ping -c 1 $PING_HOST
	then
		systemd-cat -t internet-failure-check -p emerg <<EOF
Internet failure detected!
EOF
	fi

	# Reboot countdown
		systemd-cat -t internet-failure-check -p emerg <<EOF
The system will reboot in $SLEEP_TIME seconds.
EOF
	sleep $SLEEP_TIME

	# Reboot
	touch /root/.send-mail-on-next-reboot
	reboot
fi
