---
layout: post
title: "access sharepoint webservices from java behind proxy"
description: Java Program to demonstrate how to connect and access sharepoint webservices behind proxy.
date: 2013-07-29 22:09
date_formatted: 2013-07-29 22:09
comments: true
categories: Technical
tags: java, sharepoint
keywords: Java, sharepoint, java to sharepoint with proxy, connect sharepoint from java behind proxy, access sharepoint from java behind proxy, sharepoint webservice, webservice sharepoint, ERROR 407 proxy authentication required resolved
---  

In my previous post I told you how to [access sharepoint webservices from java](http://blog.ashwani.co.in/blog/2013-07-28/connect-and-access-sharepoint-webservice-from-java/)
But what if you would like to access the sharepoint from behind a proxy, let's say from your place of work.

The approach for Authenticator mentioned [here](http://blog.ashwani.co.in/blog/2013-07-28/connect-and-access-sharepoint-webservice-from-java/) 
works if you only need to provide username/password <!--more--> for your sharepoint site and not for the proxy.
Or the other way around, when you need to provide username/password for proxy but your sharepoint site does not require any authentication, which is hardly true I guess. 
You can achieve this by setting up a default Authenticator as mentioned [here](http://blog.ashwani.co.in/blog/2013-07-28/connect-and-access-sharepoint-webservice-from-java/)


But What should you do when you require the the authentication for both proxy and the sharepoint site.
You cannot setup a single default Authenticator.    
You would get "ERROR 407 proxy authentication required", or your sharepoinnt site will deny access, based on what you setup in default autneticator.       
So what must you do? Well you can use the following code, it works in my case, hope it will work for you also.

The following approach works:    
1. If you are accessing webservices from behind the proxy.  Hence you need to specify proxyhost, proxyport, proxyuser, proxypass.    
2. If you need a username/password for sharepoint site as well. Hence you need to specify sharepointusername, sharepointpassword for authentication.    


{% codeblock %}
[SimpleAuthenticator with proxy support - SimpleAuthenticator.java]

public class SimpleAuthenticator  extends Authenticator
{
	private final static String proxyHost = "proxy.co.uk";
	private final static String proxyuser = "proxyuser";
	private final static String proxypass = "proxypass";
	private final static String sharepointusername = "sharepointusername";
	private final static String sharepointpassword = "sharepointpassword";
	private String username;
	private final char[] password;
   
   public SimpleAuthenticator(String username,String password)
   {
	   super();
	   this.username = new String(username);
	   this.password = password.toCharArray(); 
   }
   
   protected PasswordAuthentication getPasswordAuthentication()
   {
	  String requestingHost = getRequestingHost();
	  if (requestingHost == proxyHost){
		  System.out.println("getPasswordAuthentication() request recieved from->" + requestingHost );
		  return new PasswordAuthentication(proxyuser,proxypass.toCharArray());
	  }
	  else{
		  System.out.println("getPasswordAuthentication() request recieved from->" + requestingHost );
		  return new PasswordAuthentication(sharepointusername,sharepointpassword.toCharArray());
	  }
		  
   }
}
{% endcodeblock %}

In your main class , don't set the default Authenticator and instead use this.   

{% codeblock %}
[SharePointClient - SharePointClient.java https://gist.github.com/TheAshwanik/983fde4be42022ac1f29]

	Authenticator.setDefault(new SimpleAuthenticator("", ""));
	System.out.println("Configuring Proxy settings");
	System.getProperties().put("http.proxyHost",proxyHost);
	System.getProperties().put("http.proxyPort",proxyPort);
	System.getProperties().put("https.proxyHost",proxyHost);
	System.getProperties().put("https.proxyPort",proxyPort);
	
{% endcodeblock %}


That's it.  I update the previous gist [here](https://gist.github.com/TheAshwanik/983fde4be42022ac1f29)

<br/>
