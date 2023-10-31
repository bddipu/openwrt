# Openwrt Router Connectivity Check
Openwrt ash script to check connectivity of router and restart network service if two successive checks (within 5 min) fail.

1. Copy the "connectivity_check.sh" file to home directory of root (e.g. /root/)
2. Run "crontab -e" as root
3. Add below entry,
   #/5 * * * * ping -c1 -q 1.1.1.1 >/dev/null 2>&1 || sh /root/connectivity_check.sh
4. Above entry in cron will make a silent ping. If ping fails, it will run the script to check whether another failure occured within last 5 min.
5. If this is first failure within last 5 min, the script will save the timestamp in a temporary file to compare during next failure.
6. If this is second failure within last 5 min, the script will restart the network service.
7. If you want router to reboot on successive failure, change "/etc/init.d/network restart" to "/sbin/reboot" in "connectivity_check.sh" file.
