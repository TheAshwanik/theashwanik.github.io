---
layout: post
title: HAProxy for load balancing
description: How to setup HAProxy for load balancing
date_formatted: 2019-03-25 19:47
date: 2019-03-25
comments: true
categories: [Technical]
tags: HAProxy, Load balancing
keywords: HAProxy, Load balancing,LetsEncrypt, certificates, TCP/HTTP Load Balancer, High Performance TCP/HTTP Load Balancer 
---

HAProxy, which stands for High Availability Proxy, is a popular open source software TCP/HTTP Load Balancer and proxying solution which can be run on Linux, Solaris. 
Improves the performance and reliability of a server environment by distributing the traffic across servers (e.g. web, application, database). 
It is used in many high-profile environments websites.   

In this guide, I will provide a general overview of what HAProxy is, basic load-balancing terminology, and examples of how it might be <!--more--> used to improve the performance and reliability of your own server environment.

This post is about some setup required for [HAProxy](http://cbonte.github.io/haproxy-dconv/1.9/intro.html)

HAProxy can balance requests between any application that can handle HTTP or even TCP requests.

### Install HAProxy on Pi
Credit goes to [load-balancing-with-haproxy](https://serversforhackers.com/c/load-balancing-with-haproxy)

```
sudo apt-get update
sudo apt-get install -y haproxy
```  


### HAProxy Configuration

``` 

HAProxy configuration can be found at /etc/haproxy/haproxy.cfg. Here's what we'll likely see by default:

sudo vi /etc/haproxy/haproxy.cfg


global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # Default ciphers to use on SSL-enabled listening sockets.
        # For more information, see ciphers(1SSL). This list is from:
        #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
        # An alternative list with additional directives can be obtained from
        #  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
        ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
        ssl-default-bind-options no-sslv3

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http
        
        
frontend www-http
        bind *:80
        mode http
        default_backend http-nodes

frontend www-https
        bind *:443 ssl crt /etc/ssl/private/letsencrypt-ForHaproxy.pem
        reqadd X-Forwarded-Proto:\ https
        acl letsencrypt-acl path_beg /.well-known/acme-challenge/
        use_backend letsencrypt-backend if letsencrypt-acl
        default_backend http-nodes

backend letsencrypt-backend
        server letsencrypt 127.0.0.1:54321

backend http-nodes
        mode http
        balance roundrobin
        option forwardfor
        http-request set-header X-Forwarded-Port %[dst_port]
        http-request add-header X-Forwarded-Proto https if { ssl_fc }
        option httpchk HEAD / HTTP/1.1\r\nHost:localhost

        #redirect scheme https if !{ ssl_fc }
        server web01 127.0.0.1:9000 check
        server web02 127.0.0.1:9001 check


listen stats
        bind *:1936
        stats enable
        stats uri /
        stats hide-version
        stats auth username:password


```




## 
## LetsEncrypt Certificate

 
Use [acme-nginx](https://github.com/kshcherban/acme-nginx) to generate letsencrypt site for your site.

```
sudo cat /etc/ssl/private/letsencrypt-domain.key /etc/ssl/private/letsencrypt-domain.pem > /etc/ssl/private/letsencrypt-ForHaproxy.pem
sudo mv letsencrypt-ForHaproxy.pem /etc/ssl/private/
sudo chown -R user:group /etc/ssl/private/letsencrypt-ForHaproxy.pem

```


### Resources
[Who is using HAProxy](https://www.haproxy.org/they-use-it.html)    
[HAProxy Introduction](http://cbonte.github.io/haproxy-dconv/1.9/intro.html)   
https://serversforhackers.com/c/load-balancing-with-haproxy   
https://serversforhackers.com/c/using-ssl-certificates-with-haproxy     

