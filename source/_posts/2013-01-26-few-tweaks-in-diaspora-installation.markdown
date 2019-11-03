---
layout: post
title: "Few Tweaks in Diaspora installation"
description: 
date: 2013-01-26 19:41
date_formatted: 2013-01-26 19:41
comments: true
categories: Technical
tags: diaspora
keywords: diaspora, diaspora installation, typhoeus issue , rmagick issue, Cannot find Magick-config
---

Recently I wanted to checkout the [Diaspora](https://joindiaspora.com/) project, and to my despair I faced lot of problems
installing it in Windows OS.  
I could not install it on Windows, and I did'nt want to invest lot of time , as it was not important and I was trying
this only for killing my time.  However, I installed it on a VM (Ubuntu) and faced a few problems.  
<!--more-->

This post is about keeping a note of what I faced and use it in future (if needed).
####1. Issue with installing **rmagick**:####

<small>
{% codeblock rmagick installation issue %}
ERROR:  Error installing rmagick:
    ERROR: Failed to build gem native extension.

/usr/local/bin/ruby extconf.rb
checking for Ruby version >= 1.8.5... yes
checking for gcc... yes
checking for Magick-config... no
Can't install RMagick 2.13.1. Can't find Magick-config in /usr/local/bin:/bin:
/sbin:/usr/bin:/usr/sbin:/usr/libexec
.
.
.
Gem files will remain installed in /usr/local/lib/ruby/gems/1.8/gems/rmagick-2.13.1 for inspection.
Results logged to /usr/local/lib/ruby/gems/1.8/gems/rmagick-2.13.1/ext/RMagick/gem_make.out
Building native extensions.  This could take a while....
{% endcodeblock %}
</small>

I found a solution [here](https://gist.github.com/4012713)  but it did not work for me.

To solve the rmagick issue, run the following commands:

{% codeblock Run the following commands to fix issues with rmagick %}
sudo apt-get install libmagickcore-dev libmagickwand-dev  
sudo gem install rmagick
{% endcodeblock %}

<br/>
<br/>

####2. Issue with installing **typhoeus**:####

<small>
{% codeblock rmagick installation issue %}
If you get this:

Installing typhoeus (0.3.3) with native extensions
/usr/local/lib/site_ruby/1.8/rubygems/installer.rb:483:in `build_extensions': 
ERROR: Failed to build gem native extension. (Gem::Installer::ExtensionBuildError)

/usr/bin/ruby1.8 extconf.rb 
checking for curl/curl.h in /opt/local/include,/opt/local/include/curl,/usr/include/curl,
/usr/include,/usr/include/curl,/usr/local/include/curl... no
need libcurl

{% endcodeblock %}
</small>

You can fix it by installing the libcurl3-dev package:
{% codeblock commands to fix issues with typhoeus %}
sudo apt-get install libcurl3-dev
sudo apt-get install typhoeus
{% endcodeblock %}

<br/>
<br/>

I did not want to use mysql2 adapter for diaspora 
so I had to install postgreSQL (Since sqlite had problems with some length of index names)

{% codeblock installing postgresql in linux %}
sudo apt-get install postgresql-9.1
{% endcodeblock %}   
   
   
If you find issue in some gem which depends on curl, then you must install curl first.
{% codeblock installing curl %}
sudo apt-get install curl
{% endcodeblock %}

That's all folks.    
**au revoir**     
   
      
      

