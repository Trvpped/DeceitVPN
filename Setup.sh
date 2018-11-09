#!/bin/bash
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
ULG='\e[4;1;32m'
WHITE='\e[1;37m'
NC='\e[0m'

echo -e "${GREEN}DeceitVPN Auto Setup Script [Shell]"
sleep 1
echo -e "${LIGHTGREEN}Are You Root? [Y/n]"
echo -e "${LIGHTGREEN}If Answer = No, Break The Script With CTRL+C, Then Gain Sudo Privs..." read root
sleep 1
echo -e "${LIGHTGREEN}Do You Want Deceit To Check For System Updates ? [Y/n]"
read answer
yum update
echo -e "${RED}Installing Required System Packages Please Wait..."
yum groupinstall "Development Tools" -y && yum install kernel-devel wget -y
sleep 2
wget https://www.softether-download.com/files/softether/v4.27-9668-beta-2018.05.29-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.27-9668-beta-2018.05.29-linux-x64-64bit.tar.gz
sleep 1
tar -xzf soft*
sleep 1
rm -rf *.tar.gz
sleep 1
cd vpn*
sleep 1
make
sleep 1
cd ..
sleep 1
mv vpnserver /usr/local/
sleep 1
chmod 600 * /usr/local/vpnserver
sleep 1
chmod 700 /usr/local/vpnserver/vpncmd
sleep 1
chmod 700 /usr/local/vpnserver/vpnserver
echo '#!/bin/sh
# description: SoftEther VPN Server
### BEGIN INIT INFO
# Provides:          vpnserver
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: softether vpnserver
# Description:       softether vpnserver daemon
### END INIT INFO
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0' > /etc/init.d/vpnserver
sleep 2
echo -e "${RED}Giving Softether vpnserver Permissions To Execute..."
sleep 1
chmod 755 /etc/init.d/vpnserver
sleep 1
echo -e "${LIGHTGREEN}Adding Softether To System Startup..."
sleep 2
chkconfig --add vpnserver
echo -e "${LIGHTGREEN}Starting The VPN Service" 
../etc/init.d/vpnserver start
echo -e "${PURPLE}Before We're Done, Would You Like To FIX Conflicting NAT Problems For Gaming?[Y/N]" read NAT
sh FixNAT.sh
