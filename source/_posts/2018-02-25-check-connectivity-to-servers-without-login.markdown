---
layout: post
title: Check Connectivity to servers without login
description: Check Connectivity to servers without login 
date: 2018-02-25 22:57:31
date_formatted: 2018-02-25 22:57:31
comments: true
categories: Technical
tags: telnet, ssh, connectivity
keywords: telnet, ssh, connectivity, connectivity check, linux, windows connectivity,test-connection, powershell
---

There are times when you would want to check connectivity to your servers without actually login or SSH. You can use telnet on port 22. 
But here are few other ways:
<!-- more -->

### Linux/Unix - Choose one of the below


```

#! /bin/bash

rm good no_auth other
while read ip host ; do
    status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 $ip echo ok 2>&1)
    if [[ $status == ok ]] ; then
        echo $ip $host >> good
    elif [[ $status == "Permission denied"* ]] ; then
        echo $ip $host $status >> no_auth
    else
        echo $ip $host $status >> other
    fi
done < $1 
```  

``` 

#! /bin/bash
while read ip host ; do
        echo quit | telnet $ip 22 2>/dev/null | grep Connected >> resultsOfTelnetTests.txt
        
        # OR
        # $ ssh -q -o "BatchMode=yes" skinner "echo 2>&1" && echo $host SSH_OK || echo $host SSH_NOK
        
        # OR
        # $ ssh -o BatchMode=yes -o ConnectTimeout=5 skinner echo ok 2>&1
done < $1
``` 
  
      
      

### Windows
```
Script
=====

foreach($line in Get-Content .\serverList1.txt) {
      try{
      		test-connection $line -Count 1 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32 | Select Address,IPv4Address,ResponseTime,BufferSize
      }catch [Exception] {
      		echo .$line Not reachable.
      }
}


Serverlist1.txt contains the hostnames, one hostname in one line.

```
