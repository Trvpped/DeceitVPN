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

echo -e "${CYAN}Fixing NAT for Moderate/Strict VPN Servers..."
yum install firewalld
sleep 1
systemctl stop firewalld
systemctl mask firewalld
sleep 2
echo -e "${RED}Installing Required Packages"
yum install update -y
echo -e "${LIGHTGREEN}System Is up to Date..."
sleep 1
echo -e "${RED}Installing Iptables Services"
yum install iptables-services -y
sleep 1
echo -e "${LIGHTGREEN}Enabling IPtables As System Service"
systemctl enable iptables
echo -e "${LIGHTGREEN}Iptables Was Successfully Loaded & Added To System Services" 
