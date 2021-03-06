#!/bin/bash
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.



wget http://files.directadmin.com/services/all/csf/csf_install.sh  
/bin/sh ./csf_install.sh
chkconfig --level 235 csf on  
service csf restart
/sbin/iptables -I INPUT 1 -p tcp --dport 2222 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 21 -j ACCEPT  
/sbin/iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
/sbin/iptables -I INPUT 1 -p tcp --dport 25 -j ACCEPT 
/sbin/iptables -I INPUT 1 -p tcp --dport 465 -j ACCEPT
/sbin/iptables -I INPUT 1 -p tcp --dport 587 -j ACCEPT  
service iptables save  
echo "letsencrypt=1" >> /usr/local/directadmin/conf/directadmin.conf  
echo "enable_ssl_sni=1" >> /usr/local/directadmin/conf/directadmin.conf
echo "check_subdomain_owner=0" >> /usr/local/directadmin/conf/directadmin.conf  
echo "hide_ip_user_numbers=0" >> /usr/local/directadmin/conf/directadmin.conf 
/etc/init.d/directadmin restart  
wget -O /usr/local/directadmin/scripts/letsencrypt.sh http://files.directadmin.com/services/all/letsencrypt.sh  
cd /usr/local/directadmin/custombuild  
./build update  
./build letsencrypt  
./build rewrite_confs
