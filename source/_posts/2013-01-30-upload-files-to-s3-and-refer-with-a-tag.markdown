---
layout: post
title: "Octopress Plugin to Upload files to S3 and refer with a tag in html views"
description:  An octopress plugin to upload files to AWS S3 account and Provide a tag to reference the files in your views.
date: 2013-01-30 08:04
date_formatted: 2013-01-30 08:04
comments: true
categories: Technical
tags: Octopress Plugin, S3, AWS
keywords: S3, AWS S3, upload, octopress plugin, s3 image tag
---

Hello again, This time I wrote an octopress plugin which will upload the files from your local directory to your 
S3 account and provide you a tag which you can refer in your html views.    

The uploading takes place at the time <!--more--> of generating your site with the help of security credentials 
from your ENV variables settings.    


You can get the source at github here: [aws_s3_imagetag](https://github.com/TheAshwanik/aws_s3_imagetag)   
   
This is how you can setup:    
#### [aws_s3_imagetag](https://github.com/TheAshwanik/aws_s3_imagetag) ####
 
An octopress plugin to upload files to AWS S3 account and Provide a tag to reference the files in your views.

Place your files under the directory defined as your env variable S3_DIR (see enviroment variables below). When you generate your site the files will be 
uploaded to your S3 AWS account. and then you can use the tag 'AWS_S3_Image' which allows you reference images we just hosted on Amazon S3 
within your posts.  A bit of a contrived example, but it demonstrates the process of creating custom Liquid tags.

To use it, just host some place some images in $S3_DIR (they will be made publicly accessible) and use the tag with the syntax    

{% comment %}    
	{% AWS_S3_Image filename [bucket:bucket_name] [folder:folder_name] %}
{% endcomment %}   

If you don't specify a bucket name and folder name in the view, it will look for an environment variable.


#### Environment Variable ####
(I did not want to expose the credential by accendently checking in the code, so using ENV variables )    

    export AWS_BUCKET=your bucket name     
    
    \# if your images are under a folder inside the bucket  
    export AWS_BUCKET_FOLDER=folder name               
          
    export AWS_ACCESS_KEY_ID=Your S3 Access Key     
    
    export AWS_SECRET_ACCESS_KEY=Your S3 Secret key     
    
    \# Directory from where the files will be uploaded   
    export S3_DIR=source/images/TO_S3                   
    
    \# set false if you dont want to upload and just use the tag to refer s3 images/files    
    export AWS_UPLOAD=true                            
    
    
#### Example ####
{% comment %}
    Here is an image:  {% AWS_S3_Image filename [bucket:bucket_name] [folder:folder_name] %} 
    Here is an image:  {% AWS_S3_Image ash2.jpg bucket:my.bucket folder:friends/avatars/000/000/003/original %}  
    Here is an image:  {% AWS_S3_Image myimage.jpg %}  # with configuration used form _config.yml    
{% endcomment %}   


\# If you want to avoid referencing the annoyingly long aws s3 url, you can set your custom domain url 
and set it as an env variable       
 
    export AWS_CUSTOM_DOMAIN=pics.mydomain.com   
        
In this case the final html will have image tag as   
\<img src="http://pics.mydomain.com/folder/image.jpg">         
     
And you can avoid the URLs in form of    
\<img src="https://s3.amazonaws.com/bucket/folder/image.jpg">      
     
You will have to set up CNAME entry for your domain name , I will cover that in another post.

Chow...    
<br/>
