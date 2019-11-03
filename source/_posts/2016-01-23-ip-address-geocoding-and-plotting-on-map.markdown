---
layout: post
title: "IP Address GeoCoding and Plotting on map"
description: The Post is about how to visualize the geo location of IP addresses that may have been involved in attacking your server. from different computer.
date: 2016-01-23 21:49:37
date_formatted: 2016-01-23 21:49:37
comments: true
categories: Technical
tags: ipaddress, geocoding , webattacks , IP-block
keywords: Ip address blocking, IP Address geocoding, visualize attack locations
---

Sometimes back I had setup ssh on raspberry pi and allowed to login from internet, obviously using the public key encyption.
After few days I noticed that lot of people/systems were trying to login and failing from various different IPs.
So I block them using Fail2ban. I am Not gonna talk about Fail2ban, as its completely vast topic on its own.

<!--more-->

[Fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page) : It provides a way to automatically protect virtual servers from malicious behavior.
The program works by scanning through log files and reacting to offending actions such as repeated failed login attempts.

Once blocked I wanted to see from where I was getting attacked the most. So I plotted them on map using some free apis.
Here is my fail2ban config for creating a file of all blocked IP addresses.

{% codeblock %}
/pathToFail2ban/action.d/iptables-multiport.conf

[Definition]

# Option:  actionstart
# Notes.:  command executed once at the start of Fail2Ban.
# Values:  CMD
#

actionstart = iptables -N fail2ban-<name>
              iptables -A fail2ban-<name> -j RETURN
              iptables -I <chain> -p <protocol> -m multiport --dports <port> -j fail2ban-<name>
              cat /etc/fail2ban/ip.blacklist.persistban.<name> | while read IP; do iptables -I fail2ban-<name> 1 -s $IP -j DROP; done



# Option:  actionban
# Notes.:  command executed when banning an IP. Take care that the
#          command is executed with Fail2Ban user rights.
# Tags:    <ip>  IP address
#          <failures>  number of failures
#          <time>  unix timestamp of the ban time
# Values:  CMD
#
actionban = iptables -I fail2ban-<name> 1 -s <ip> -j DROP
            echo <ip> >> /etc/fail2ban/ip.blacklist.persistban.<name>
            echo <ip> >> /pathToMysite/blocked_ipaddresses.txt
{% endcodeblock %}


I used [ipmapper](http://lab.abhinayrathore.com/ipmapper/) which uses google maps api for geocoding.

Here is my html code to plot those blocked IPs.

{% codeblock %}
<html>
<head>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="ipmapper.js"></script>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style>
      html, body, #map {
        height: 100%;
        margin: 0px;
        padding: 0px;
      }
    </style>
    <script type="text/javascript">
    $(function(){
        try{
                var useragent = navigator.userAgent;
                var mapdiv = document.getElementById("map");
                console.log(useragent.indexOf('iPhone'));
                if (useragent.indexOf('iPhone') == -1 || useragent.indexOf('Android') == -1 ) {
                        mapdiv.style.width = '100%';
                        mapdiv.style.height = '100%';
                } else {
                        mapdiv.style.width = '600px';
                        mapdiv.style.height = '800px';
                }

                IPMapper.initializeMap("map");

                var file = "../data/blocked_ipaddresses.txt";
                var ipArray = new Array();
                $.get(file, function(data){
                        ipArray = data.split('\n');
                        //console.log("Raw array length is -" + ipArray.length);
                        IPMapper.addIPArray(ipArray);
                });

        } catch(e){
            //handle error
        }
    });
    </script>
</head>
<body>
    <div id="map" style="height: 800px;"></div>
</body>
</html>
{% endcodeblock %}


Here is the output plotted on the map... :) 

![alt ](/images/bot_attacks_on_pi.jpg "Bot attack image - not able to load pic.")

hmm.. lot of friendly visits from China and Russia... :)

Chow...

<br/>






