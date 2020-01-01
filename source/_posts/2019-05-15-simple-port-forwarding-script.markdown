---
layout: post
title: Simple Port Forwarding script
description: Simple script to find a free port and perform  Port Forwarding
date: 2019-05-15 19:29
date_formatted: 2019-05-15 19:29
comments: true
categories: Technical
tags: SSH, Port Forwarding, Tunneling
keywords: SSH, Port Forwarding, Tunneling, Local port forward, unused port, forward port, ssh port forwarding
---


Port forwarding allows remote computers (for example, computers on the Internet) to 
connect to a specific computer or service within a private local-area network (LAN).    
Source:[Wiki](http://en.wikipedia.org/wiki/Port_forwarding)

Here is my version of local port forwarding.
I created a script for finding me a local unused port <!--more--> and then forward all traffic on 
that local port to some remote server on a predefined port.



{% codeblock %}
// Create a script called portForward.sh
// (This has to be run from the Server where you need to setup port forwarding)
//
Port=32000  // Set initial port to start lookup from.
while netstat -atwn | grep "^.*:${Port}.*:\*\s*LISTEN\s*$"
do
	echo "Port $Port is already used"
	Port=$(( ${Port} + 1 ))
done
echo "Looks like you get port ${Port}."  // Say you got 32003

//ssh -f userOfRemoteServer@remoteserverIP -L LocalhostIPaddress:localport:RemotehostIPaddress:remoteport -N
ssh -f user@10.145.2.233 -L 10.115.13.108:${Port}:10.145.2.233:8000 -N

{% endcodeblock %}

The above script will forward all the traffic on 10.115.13.108:32003 to 10.145.2.233:8000.

Please note that you will need a user to be existing on 10.145.2.233.  The script will ask you for the password.

Hope this helps someone.


To read more about different types of port forwarding etc, See also:   
<http://www.debianadmin.com/howto-use-ssh-local-and-remote-port-forwarding.html>    
<http://www.networkactiv.com/AUTAPF.html>   
<https://help.ubuntu.com/community/SSH/OpenSSH/PortForwarding>   
<http://www.revsys.com/writings/quicktips/ssh-tunnel.html>   
