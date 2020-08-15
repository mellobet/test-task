#!/bin/sh

# Clean ka states
/bin/rm -f /run/keepalived.pid
/bin/rm -f /run/vrrp.pid
/bin/rm -f /var/run/keepalived.pid
/bin/rm -r /var/run/vrrp.pid

# Commented out to fulfill True active-passive behavior (shutted down nginx on backup-state) - set keepalived as main docker process.
# /usr/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console &

/usr/sbin/keepalived --use-file /etc/keepalived/keepalived.conf --dont-fork --log-console --log-detail

# Commented out to fulfill True active-passive behavior (shutted down nginx on backup-state)
# nginx -g "daemon off;"
