---
layout: post
title: "Proxies Explained or Demystified"
description: Difference between forward and reverse proxy
date_formatted: 2019-11-02 23:46
date: 2019-11-02
comments: true
categories: [Technical]
tags: proxy
keywords: proxy, proxies, reverse proxy, Forward proxy
---

Proxy is Essentially, a middle man. 
When dealing with computers the concept is largely the same. A web proxy is simply a bit of software that will relay a HTTP request for you.

This post is about - Proxies Made Easy or as my good friend at [very good security](verygoodsecurity.com) say - "Proxies Demystified.."

### What is a Proxy
HTTP Proxies are an essential component when using the internet day to day - load balancers, routers, content <!--more--> accelerators, content protection systems, these are all simple examples of web proxies and they all act as intermediaries to send your HTTP requests where they need to go, anonymize requests, handle routing of traffic, speed up the net, and many other uses.

[Google defines](https://www.google.com/search?q=what+is+a+proxy) a proxy as

```
the authority to represent someone else
```

When it comes down to it, most web proxies fall into two camps:  

1.	**Reverse Proxies** - A reverse proxy is usually an internal-facing proxy used as a front-end to control and protect access to servers on a private network. A reverse proxy commonly also performs tasks such as load-balancing, authentication, decryption or caching.
2.	**Forward Proxies** - A forward proxy is an Internet-facing proxy used to retrieve from a wide range of sources.
Let.s look at these two types in more detail

### What is a Reverse Proxy
You.re probably using a reverse proxy in order to view this content. When you make a request to the server that serves this blog post it will pass through a load balancer. This load balancer is a type of reverse proxy. Reverse proxies will sit in front of one of more servers and distribute requests to these servers. Common examples of these would be Nginx.s proxy_pass module, HAProxy, Squid, and AWS. ELB.

Let.s look at an example of a reverse proxy:

Reverse Proxy
[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/6/67/Reverse_proxy_h2g2bob.svg)](https://upload.wikimedia.org/wikipedia/commons/6/67/Reverse_proxy_h2g2bob.svg)

You can see in this graphic that the reverse proxy receives a request from a client on the internet and retrieves the requested resources from one of more servers that sit behind it. To the client there is no knowledge required of the servers (often called upstream servers) that serve the original content and they can be changed as required without any outside knowledge. The reverse proxy handles that information. 

As part of this handling of the request the reverse proxy will often provide additional value such as terminating SSL, performing authentication and/or authorization, accelerating (caching or compressing) content or rewriting the request and/or response.

The word .reverse. in the name reverse proxy has no special meaning, it.s just used as the inverse of forward proxy which actually has a meaning as you.ll read shortly.

### What is a Forward Proxy
Forward proxies are commonly used to control traffic leaving networks. When you send a request via the proxy it will .forward. your request on to the requested website, hence the name .Forward Proxy..

A common job of a forward proxy is to both control access to the internet by inspecting certain attributes as the request passes through it. If you.re on a corporate network and they prohibit you from going to a social network such as facebook.com, this will often be the job of a forward proxy. The forward proxy is able to inspect the host of the request and, since on a corporate network traffic is often mandated to flow through the proxy, it will deny any requests that use the prohibited host.

A similar implementation to the above will scan outbound content of the payload as it passes through the proxy. This can be used for a variety of data protection applications e.g., for data loss prevention; or scan content for malicious software.

Another common use-case for a forward proxy is to anonymize where the request originally came from.

Let.s look at an example of a forward proxy:

Forward Proxy
[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/1/19/Forward_proxy_h2g2bob.svg)](https://upload.wikimedia.org/wikipedia/commons/1/19/Forward_proxy_h2g2bob.svg)

As you can see it sits in between requests from the user to the internet. As such, when the forward proxy sends a request to a host the host computer will see the IP address of the forward proxy, not of the user. This is commonly used to perform IP anonymization and is a major feature of VPNs.

#### Layer 7 versus layer 3
Most of the time .proxy. refers to a layer-7 application on the OSI reference model. However, another way of proxying is through layer-3 and is known as Network Address Translation (NAT). The difference between these two proxy technologies is the layer in which they operate, and the procedure to configuring the proxy clients and proxy servers.

Layer-7 proxies are more suitable if you.re inspecting the content of the payload to perform routing or otherwise manipulating the payload.

References    
   [Youtube link](https://www.youtube.com/watch?v=s25cSWkGD38)    
   [Quora  - Whats-the-difference-between-a-reverse-proxy-and-forward-proxy](https://www.quora.com/Whats-the-difference-between-a-reverse-proxy-and-forward-proxy)    
   [Jscape - Forward-Proxy-vs-Reverse-Proxy](http://www.jscape.com/blog/bid/87783/Forward-Proxy-vs-Reverse-Proxy)     
   [Citrix - reverse-vs-forward-proxy](https://www.citrix.com/blogs/2010/10/04/reverse-vs-forward-proxy/)    
   [Google - forward+versus+reverse+proxy](https://www.google.com/search?q=forward+versus+reverse+proxy)    
   [Apache - mod_proxy.html#forwardreverse](http://httpd.apache.org/docs/2.0/mod/mod_proxy.html#forwardreverse)    



Disclaimer:
**This is Collaboration post with verygoodsecurity.com and this post is directly published on collaboration request from Eugene - genewalz.xxxx@gmail.com     
[Original article](https://blog.verygoodsecurity.com/posts/proxies-demystified/)



