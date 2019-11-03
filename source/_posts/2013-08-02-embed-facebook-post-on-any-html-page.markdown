---
layout: post
title: "Embed Facebook Post on any html page"
description: How To embed Facebook post on any HTML page
date: 2013-08-02 22:41
date_formatted: 2013-08-02 22:41
comments: true
categories: Technical
tags: Facebook
keywords: Facebook post, embed facebook post, embed FB post, embed post, facebook post inside html
---  

Facebook has released a new feature. It's called “embedded posts”.   
But officially, only Big Publishers can embed posts currently into their pages.

We can also, embed the **Public** FB posts with a small script and trick.    

1.Go to any facebook post and hover over the date when post was created. Right-Click and copy the Link. <!--more-->   
2.Replace the URL_HERE with the link you just copied.   

{% codeblock Sample to embed FB post in HTML page index.html %}
<!DOCTYPE html>
<html xmlns:fb="http://ogp.me/ns/fb#" lang="en">
<head>     
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>
  <body>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes" />

		<div id="fb-root"></div>
		<script>
		(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
		return;
		js = d.createElement(s);
		js.id = id;
		js.src = "http://connect.facebook.net/en_US/all.js#xfbml=1";
		fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
		</script>
		
		<fb:post href="URl_HERE"></fb:post></p>
		<p style="text-align: justify;">
	 </body>
</html>
{% endcodeblock %} 


####Here is an example:

<div id="fb-root">
</div>
<p>
<script>
(function(d, s, id) 
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id))
	return;
	js = d.createElement(s);
	js.id = id;
	js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<br />
		
<fb:post href="https://www.facebook.com/TheAshwanikBlog/posts/182463588593799">
</fb:post>
</p>

Enjoy and Embed your FB post where ever you like.    

Courtesy: Amit Agarwal's [Video](https://www.youtube.com/watch?feature=player_embedded&v=0hh8lKDnFWI)

<br/>
