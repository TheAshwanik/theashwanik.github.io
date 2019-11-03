---
layout: post
title: "Flash based Tag Cloud plugin for Octopress site"
description: Flash based Tag Cloud plugin for Octopress site. It's an extension of Flash based Cloud Tag by Joseph Chang (https://github.com/bizkit)
date: 2013-01-19 11:13
date_formatted: 2013-01-19 11:13
comments: true
categories: Technical
tags: Flash, Tag cloud, Tag, animated cloud, Octopress Plugin
keywords: Flash, Flash based, animation, tag cloud, octopress tag cloud, flash tag cloud
---

I recently wanted to use a Animated Flash based Tag Cloud on my Blog site. 
Then I came across with a plugin from Joseph Chang (octopress-cumulus), but unfortunately it generated only category clouds.

So I updated the plugin to create a flash based animated cloud for tags also.<!--more-->   
Note: you will have to use any other plugin to generate the tags first.

Here is the plugin code:
{% gist 4578668 category_cloud.rb %}

		
		
You can also find the updated plugin here.  
<a href="https://github.com/TheAshwanik/octopress-cumulus.git">Github - TheAshwanik/octopress-cumulus</a>
or here <a href="https://github.com/bizkit/octopress-cumulus.git">Github - bizkit/octopress-cumulus</a>
