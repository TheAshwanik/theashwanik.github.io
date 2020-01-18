---
layout: post
title: "OpenVPN on Raspberry Pi"
description: "How to install and configure OpenVPN on Raspberry Pi"
date_formatted: 2017-03-14 23:06
date: 2017-03-14
comments: true
categories: [Technical]
tags: Raspberry, PI, OpenVpn
keywords: OpenVPN, VPN
---
## Everyone loves something Free.

Open and Free wireless is everywhere, but should you be connecting to it. **The answer is NO**.
You shouldn.t be connecting to it, dont connect to your social networks, don't check your bank account on it unless you want somebody else to be able to sneak on it. 

The solution? A virtual private network, or VPN.
A VPN extends your own private network into public places, so even if you.re using Starbucks. Wi-Fi connection, your Internet browsing stays encrypted and secure.<!--more-->
The easiest and cheapest solution to keep your data safe is to just refrain from public Wi-Fi completely. But then some times we don't have a choice and we do require to connnect to insecure network. But we can save ourselves with an inexpensive to build own VPN server at home, and run it off of a tiny, inexpensive Raspberry Pi. 

A VPN - or virtual private network - helps you browse the internet more anonymously by routing your traffic and encrypting it through a server that is not your point of origin.

Create a directory for VPN stuff. Ignore if you dont want to..
Install the openvpn package

{% codeblock %}
$ mkdir VPN && cd VPN
$ sudo apt-get install openvpn
{% endcodeblock %}

## Generating keys
Your VPN needs keys generated to make sure that only authorised devices can connect to it.
OpenVPN comes with Easy_RSA, a simple package for using the RSA encryption method to generate your unique keys.

Switch to root.   

{% codeblock %}
sudo -s
{% endcodeblock %}

You will now see your command prompt sits at 'root@XXXXX:'    
root@XXXX/VPN# cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/update-resolv-conf    

Next, create the keys needed by both server and client   
{% codeblock %}

mkdir /etc/openvpn/easy-rsa    

cp -ai /usr/share/doc/openvpn/examples/easy-rsa/2.0/ /etc/openvpn/easy-rsa    

cd /etc/openvpn/easy-rsa/2.0   

vi vars   

In the vars file, edit the KEY_* entries at the bottom of the file, such as KEY_COUNTRY, KEY_ORG, KEY_EMAIL, etc. Next, source the vars file and then clean the directory.    

. ./vars    

./clean-all    
{% endcodeblock %}

## Build the certifying Authority
{% codeblock %}
/etc/openvpn/easy-rsa/2.0# ./build-ca   

Generating a 2048 bit RSA private key    
writing new private key to 'ca.key'
-----
You are about to be asked to enter information that will be incorporated into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [US]:IN
State or Province Name (full name) [CA]:KA
Locality Name (eg, city) [SanFrancisco]:BLR
Organization Name (eg, company) [Fort-Funston]:MyCompany
Organizational Unit Name (eg, section) [changeme]:MyOrg
Common Name (eg, your name or your server's hostname) [changeme]:MyserverName
Name [changeme]:NoName
Email Address [mail@host.domain]:
{% endcodeblock %}


## Build the Server Key
{% codeblock %}
/etc/openvpn/easy-rsa/2.0# ./build-key-server MyserverName   

Generating a 2048 bit RSA private key
writing new private key to 'MyserverName.key'
-----
You are about to be asked to enter information that will be incorporated into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [US]:IN
State or Province Name (full name) [CA]:KA
Locality Name (eg, city) [SanFrancisco]:BLR
Organization Name (eg, company) [Fort-Funston]:MyCompany
Organizational Unit Name (eg, section) [changeme]:MyOrg
Common Name (eg, your name or your server's hostname) [MyserverName]:
Name [changeme]:NoName
Email Address [mail@host.domain]:

Please enter the following 'extra' attributes to be sent with your certificate request

A challenge password []:
An optional company name []:
Using configuration from /etc/openvpn/easy-rsa/2.0/openssl-1.0.0.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
countryName           :PRINTABLE:'IN'
stateOrProvinceName   :PRINTABLE:'KA'
localityName          :PRINTABLE:'BLR'
organizationName      :PRINTABLE:'MyCompany'
organizationalUnitName:PRINTABLE:'MyOrg'
commonName            :PRINTABLE:'MyserverName'
name                  :PRINTABLE:'NoName'
emailAddress          :IA5STRING:'mail@host.domain'
Certificate is to be certified until Mar 21 22:44:06 2025 GMT (3650 days)

Sign the certificate? [y/n]:y
1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
{% endcodeblock %}

## Build keys for Clients

{% codeblock %}
root@ashberrypi:/etc/openvpn/easy-rsa/2.0# ./build-key-pass officelaptop
Generating a 2048 bit RSA private key
writing new private key to 'officelaptop.key'
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [US]:IN
State or Province Name (full name) [CA]:KA
Locality Name (eg, city) [SanFrancisco]:BLR
Organization Name (eg, company) [Fort-Funston]:MyCompany
Organizational Unit Name (eg, section) [changeme]:MyOrg
Common Name (eg, your name or your server's hostname) [officelaptop]:
Name [changeme]:OfficeLappyKey
Email Address [mail@host.domain]:
Please enter the following 'extra' attributes to be sent with your certificate request
A challenge password []:
An optional company name []:
Using configuration from /etc/openvpn/easy-rsa/2.0/openssl-1.0.0.cnf
Check that the request matches the signature
Signature ok
The Subject's Distinguished Name is as follows
countryName           :PRINTABLE:'IN'
stateOrProvinceName   :PRINTABLE:'KA'
localityName          :PRINTABLE:'BLR'
organizationName      :PRINTABLE:'MyCompany'
organizationalUnitName:PRINTABLE:'MyOrg'
commonName            :PRINTABLE:'officelaptop'
name                  :PRINTABLE:'OfficeLappyKey'
emailAddress          :IA5STRING:'mail@host.domain'

Certificate is to be certified until Mar 21 22:47:52 2025 GMT (3650 days)
Sign the certificate? [y/n]:y
1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
{% endcodeblock %}

This line adds an extra layer of encryption to make it harder for hackers to break in.
{% codeblock %}
/etc/openvpn/easy-rsa/2.0# cd keys
/etc/openvpn/easy-rsa/2.0/keys# openssl rsa -in officelaptop.key -des3 -out officelaptop.3des.key
Enter pass phrase for officelaptop.key:
writing RSA key
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
{% endcodeblock %}


## Generate the Diffie-Hellman key exchange.
{% codeblock %}
This is the code that lets two entities with no prior knowledge of one another share secret keys over a public server.
/etc/openvpn/easy-rsa/2.0/keys# cd ..
/etc/openvpn/easy-rsa/2.0# ./build-dh
Generating DH parameters, 2048 bit long safe prime, generator 2
This is going to take a long time
{% endcodeblock %}

## Denial of Service (DoS) attack protection
OpenVPN protects against this kind of attack by generating a static pre-shared hash-based message authentication code (HMAC) key.    
This means the server will not try to authenticate an access request if it does not detect this key.    
To generate the static HMAC key type:       

{% codeblock %}
/etc/openvpn/easy-rsa/2.0# openvpn --genkey --secret keys/ta.key
{% endcodeblock %}

Update the sample configuration file, It should look like following in the most basic form:

{% codeblock %}
cd /etc/openvpn
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf .
#Sample
port 8443
proto udp
dev tun
user nobody
group nogroup
persist-key
persist-tun
keepalive 10 120
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "dhcp-option DNS 192.168.1.1"
push "dhcp-option DNS 8.8.8.8"
push "redirect-gateway def1 bypass-dhcp"
dh none
ecdh-curve prime256v1
tls-crypt tls-crypt.key 0
crl-verify crl.pem
ca ca.crt
cert server.crt
key server.key
auth SHA256
cipher AES-128-GCM
ncp-ciphers AES-128-GCM
tls-server
tls-version-min 1.2
tls-cipher TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256
status /var/log/openvpn/status.log
verb 3
management localhost 7213
{% endcodeblock %}

You will need to enable IP forwarding.   

{% codeblock %}
echo 1 > /proc/sys/net/ipv4/ip_forward
{% endcodeblock %}

You can make this a permanent change by uncommenting the line:    

{% codeblock %}
net.ipv4.ip_forward = 1
{% endcodeblock %}

in the file /etc/sysctl.conf.   

{% codeblock %}
/etc/openvpn/easy-rsa/2.0# sysctl -p
kernel.printk = 3 4 1 3
net.ipv4.ip_forward = 1
vm.swappiness = 1
vm.min_free_kbytes = 8192
{% endcodeblock %}


Change the permissions for the firewall script    

{% codeblock %}
/etc/openvpn/easy-rsa/2.0# chmod 700 /etc/firewall-openvpn-rules.sh    
/etc/openvpn/easy-rsa/2.0# chown root  /etc/firewall-openvpn-rules.sh    
{% endcodeblock %}

Find the line that is either iface eth0 inet dhcp or iface eth0 inet manual and enter this line below it:   

{% codeblock %}
/etc/openvpn/easy-rsa/2.0# vi /etc/network/interfaces    

pre-up /etc/firewall-openvpn-rules.sh    

Keep those spaces at the front so it.s indented, it should end up looking like this:   

iface eth0 inet manual pre-up /etc/firewall-openvpn-rules.sh    

{% endcodeblock %}

You'll also have to allow NAT forwarding through your firewall. This will most likely be accomplished with something like the following rule in iptables:

{% codeblock %}
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE   

or       

ufw allow portnum    

{% endcodeblock %}

This assumes you have set up your openvpn server with the IP 10.8.0.0 in the server.conf file as described above.

I did not do this, I opened a port on my router. Let me know if thats not right.

Now reboot.    

{% codeblock %}
# sudo reboot    
{% endcodeblock %}

Configure the Client and connect to your VPN. No Spoofing..    

Enjoy...    
