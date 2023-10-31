#!/bin/sh

## create "netcheck" file at /tmp if not exists
[ -e "/tmp/netcheck" ] || echo 0 > /tmp/netcheck

## get the time of previous failed check
last_time=$( head -1 /tmp/netcheck )

## get the time of latest  failed check
curr_time=$( date +%s )

## crontab will check connectivity in every 5 min
## if successive checks fail, network service will restart
if [ $(( (curr_time-last_time)/60 )) -gt "7" ]; then
        printf "%d" "$curr_time" >/tmp/netcheck
else
        echo /etc/init.d/network restart
fi
