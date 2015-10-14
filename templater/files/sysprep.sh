#!/bin/bash

set -e
set -u

network_config=/etc/sysconfig/network-scripts/ifcfg-eth0

# Install ovirt-guest-agent
yum install -y epel-release >/dev/null
yum install -y ovirt-guest-agent >/dev/null
chkconfig ovirt-guest-agent on

# Install cloud-init
yum install -y cloud-init >/dev/null
chkconfig cloud-init on

# Move cloud.cfg
mv /tmp/cloud.cfg /etc/cloud/cloud.cfg

# Clean up network script
sed -i '/^BOOTPROTO=/d' "$network_config"
sed -i '/^HWADDR=/d' "$network_config"
sed -i '/^ONBOOT=/d' "$network_config"
sed -i '/^TYPE=/d' "$network_config"
sed -i '/^UUID=/d' "$network_config"
sed -i 's/^NM_CONTROLLED=.*/NM_CONTROLLED=no/' "$network_config"
sed -i 's/^HOSTNAME=.*/HOSTNAME=localhost.localdomain/' /etc/sysconfig/network

# Clean up host specific stuff
rm -rf /etc/ssh/ssh_host_*
rm -rf /etc/udev/rules.d/70-*

# Clean out log files
for log in /var/log/*.log; do
	>"$log"
done
>/var/log/cron
>/var/log/lastlog
>/var/log/maillog
>/var/log/messages
>/var/log/secure
rm -f /root/anaconda-ks.{log,cfg}
rm -f /root/install.log{,.syslog}

# Ensure /var/log/audit/audit.log exists and is empty
if [ -a "/var/log/audit/audit.log" ]; then
	>/var/log/audit/audit.log
else
	mkdir -p /var/log/audit
	touch /var/log/audit/audit.log
	restorecon -vR /var/log/audit
fi

# Clean out root bash history
>/root/.bash_history
history -c

poweroff
