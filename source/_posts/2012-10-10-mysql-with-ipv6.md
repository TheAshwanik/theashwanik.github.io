---
layout: post
title: Connecting to MySQL Server Using an IPV6 Address
description: Sample code snippet for Connecting to MySQL Server Using an IPV6 Address
category: Technical
tags: ipv6, mysql
comments: true
date: 2012-10-10 15:45
date_formatted: 2012-10-10 15:45
keywords: ipv6, mysql, ipv6 address, java , myswl jdbc connector, Mysql databse, IPV6 address, java program
---

If you are one of those who does not know that there is a new way to connect to MySQL database with an IPV6 IP address,
then keep reading.
We will see how to connect to a mysql database on a server with an IPv6 address.

I struggled for this, so I wanted to document it.
Source: [Wiki IPv6](http://en.wikipedia.org/wiki/IPv6)
<!--more-->
#### Address Format ####

IPv6 addresses have two logical parts: a 64-bit network prefix, and a 64-bit host address part.

(The host address is often automatically generated from the interface MAC address.) 
An IPv6 address is represented by 8 groups of 16-bit hexadecimal values separated by colons (:) shown as follows:

A typical example of an IPv6 address is:
	
	2001:0db8:85a3:0000:0000:8a2e:0370:7334.
The hexadecimal digits are case-insensitive.


#### Method to connect to MYSQL using an IPv4 address (traditional way) ####

{% codeblock %}
urlString = “jdbc:mysql://10.144.1.216:3306/dbName”;
Class.forName(driver);
DriverManager.setLoginTimeout(getConnectionTimeOut());
dbConnection = DriverManager.getConnection(urlString,user,password);
{% endcodeblock %}

#### Method to connect to MYSQL using an IPv6 address (New way) ####
{% codeblock %}
urlString = “jdbc:mysql://address=(protocol=tcp)(host=fe80::5ed6:baff:fe14:a23e)(port=3306)/db”;
Class.forName(driver);
DriverManager.setLoginTimeout(getConnectionTimeOut());
dbConnection = DriverManager.getConnection(urlString,user,password);
{% endcodeblock %}

This new approach is no where documented over the internet, and a bug has been filed by Mark Mathews 
to include this as documentation in next release of  MYSQL JDBC connector. 
Thanks to Mark for Pointing this out to us.   

Check bugs at:		
1. [http://bugs.mysql.com/bug.php?id=59451](http://bugs.mysql.com/bug.php?id=59451)		
2. [http://bugs.mysql.com/bug.php?id=8836](http://bugs.mysql.com/bug.php?id=8836)		
 
For those who wants to know more about Ipv6:		
1. [ipv6.com](http://ipv6.com)		
2. [IPv6-Beginners_Look.htm](http://ipv6.com/articles/general/IPv6-Beginners_Look.htm)		
3. [Top-10-Features-that-make-IPv6-greater-than-IPv4.htm](http://ipv6.com/articles/general/Top-10-Features-that-make-IPv6-greater-than-IPv4.htm)		


