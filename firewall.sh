#!/bin/bash
exec >> /home/alex/fwlog
exec 2>&1

#Drop all incoming packets
/sbin/iptables -P INPUT DROP

#Check to see if a rule exists in 1. If not, create.
if 
        /sbin/iptables -R INPUT 1 -p tcp -m tcp -m multiport --dports 22,53,80,443 -j ACCEPT;
        then echo "%T: Rule 1 updated"
else /sbin/iptables -A INPUT -p tcp -m tcp -m multiport --dports 22,53,80,443 -j ACCEPT
        echo "%T: Added missing rule 1"
fi

#Check to see if a rule exists in 2. If not, create.
if 
        /sbin/iptables -R INPUT 2 -p udp --dport 53 -j ACCEPT;
        then echo "%T: Rule 2 updated"
else /sbin/iptables -A INPUT -p udp --dport 53 -j ACCEPT
        echo "%T: Added missing rule 2"
fi

#Check to see if a rule exists in 3. If not, create.
if 
        /sbin/iptables -R INPUT 3 -m state --state RELATED,ESTABLISHED -j ACCEPT;
        then echo "%T: Rule 3 updated"
else /sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
        echo "%T: Added missing rule 3"
fi
