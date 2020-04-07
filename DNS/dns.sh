#!/bin/bash

systemctl stop firewalld

systemctl disable firewalld

yum install epel-release -y

yum install wget net-tools telnet tree nmap sysstat lrzsz dos2unix bind bind-utils -y


# vi /etc/named.conf
#listen-on port 53 { 10.4.7.11; };
#allow-query     { any; };
#forwarders      { 10.4.7.254; };
#dnssec-enable no;
#dnssec-validation no;


echo '
zone "vadd.com" IN {
        type  master;
        file  "vadd.com.zone";
        allow-update { 192.168.3.244; };
};

zone "harbor.com" IN {
        type  master;
        file  "harbor.com.zone";
        allow-update { 192.168.3.244; };
};' >> /etc/named.rfc1912.zones


echo '$ORIGIN vadd.com.
$TTL 600	; 10 minutes
@       IN SOA dns.vadd.com. dnsadmin.vadd.com. (
				2020040708 ; serial
				10800      ; refresh (3 hours)
				900        ; retry (15 minutes)
				604800     ; expire (1 week)
				86400      ; minimum (1 day)
				)
			NS   dns.vadd.com.
$TTL 60	; 1 minute
dns                 A    192.168.3.224
vadd3-240           A    192.168.3.220
vadd3-241           A    192.168.3.221
vadd3-242           A    192.168.3.222
vadd3-244           A    192.168.3.223
vadd3-245           A    192.168.3.224
' > /var/named/vadd.com.zone


echo '$ORIGIN harbor.com.
$TTL 600	; 10 minutes
@   		IN SOA dns.harbor.com. dnsadmin.harbor.com. (
				2020040708 ; serial
				10800      ; refresh (3 hours)
				900        ; retry (15 minutes)
				604800     ; expire (1 week)
				86400      ; minimum (1 day)
				)
				NS   dns.harbor.com.
$TTL 60	; 1 minute
dns                A    192.168.3.244
harbor             A    192.168.3.245
k8s-yaml           A    192.168.3.245
' > /var/named/harbor.com.zone


systemctl start named
systemctl enable named
# netstat -luntp|grep 53
dig -t A vadd3-245.host.com @192.168.3.244 +short