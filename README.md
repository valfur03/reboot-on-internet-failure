# Reboot on internet failure

This script is intended to reboot a system that disconnects from the internet.

It can also an email on reboot containing the journal logs from the last boot.

## Required commands

The script uses several commands, such as `ping` and `msmtp`. Make sure you have them installed and configured.

## Configuration

### Variables

Variables template are defined in `variables.template.sh`. Copy the `variables.template.sh` file to `variables.sh` and fill the fields. You can follow the below example:

```sh
EMAIL_ADDRESS='email@example.org' # The email sender address
EMAIL_SENDER='System reboot' # The email sender name
MAX_WAIT_TIME=20 # The maximum time to wait for an internet connection before sending email
PING_DOMAIN=google.com # The domain to ping
PING_HOST=1.1.1.1 # The host to ping
SLEEP_TIME=120 # The time before the system reboots (useful to collect logs)
```

### Cron jobs

You may use any cron service to run the scripts. However, you must run the cron jobs as `root`. Here is an example file:

```cron
*/5 * * * * /root/reboot-on-internet-failure/check.sh

@reboot /root/reboot-on-internet-failure/mail.sh
```