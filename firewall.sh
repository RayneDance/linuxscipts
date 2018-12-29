#!/bin/bash
1>>/home/alex/fwlog
2>>/home/alex/fwerr

#Drop all incoming packets
/sbin/iptables -P INPUT DROP

#Check to see if a rule exists in 1. If not, create.
if 
        /sbin/iptables -R INPUT 1 -p tcp -m tcp -m multiport --dports 22,53,80,443 -j ACCEPT;
then echo "Rule 1 updated"
else /sbin/iptables -A INPUT -p tcp -m tcp -m multiport --dports 22,53,80,443 -j ACCEPT
fi

#Check to see if a rule exists in 2. If not, create.
if 
        /sbin/iptables -R INPUT 2 -p udp --dport 53 -j ACCEPT;
then echo "Rule 2 updated"
else /sbin/iptables -A INPUT -p udp --dport 53 -j ACCEPT
fi

#Check to see if a rule exists in 3. If not, create.
if 
        /sbin/iptables -R INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT;
then echo "Rule 3 updated"
else /sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
fi
