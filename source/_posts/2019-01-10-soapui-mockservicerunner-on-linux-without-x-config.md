---
layout: post
title: SOAPUI MockServiceRunner on Linux without X Config
description: SOAPUI MockServiceRunner on Linux/Unix OS without X configuration
category: Technical
tags: Soapui, XServer, Xming
comments: true
date: 2019-01-10 16:17
date_formatted: 2019-01-10 16:17
keywords: soapui, mockservicerunner, mock service, mock service in linux, X configuration, X server, mockservicerunner.sh, mockservicerunner.bat
---
Updated   

After I struggled for this problem, I am going to keep it for my refrence.
As the title says, We will see in the post how to run a SoapUI MockService on a (X)nix 
box without needing to start the X Server Configuration .


####SOAPUI - Installing on Linux/Unix####

Source:<http://www.soapui.org/Getting-Started/installing-on-linuxunix.html>
<!--more-->

 
####64-bit systems - prerequisite####

Make sure that you have Java (JRE) installed on your system

####Installation####

1.	 Download the Linux binary zip (no JRE) from http://www.soapui.org/
2.	 Unzip it into a preferable directory such as your home folder or /opt
3.	 Make sure that you have proper permissions on the unziped soapUI folder
4.	 Go into the folder and run $bin/soapui.sh (open source) or $bin/soapui-pro.sh (Pro)

 
####Mock Services####
Source: <http://www.soapui.org/Test-Automation/mock-services.html>
 

Running your MockServices from the command-line is equally simple; use the bundled mockrunner.bat/.sh file with the following arguments:
<div style="font-size:11px">
<pre id="mypre_noborder">
   m : The name of the MockService to run  
   p : The local port to listen on, overrides the port configured for the MockService  
   a : The local path to listen on, overrides the path configured for the MockService  
   b : Turns off blocking when mockRunner has been started, which is required when wanting to run the MockServiceRunner with (for example) nohup or as a Windows Service  
   s : The soapui-settings.xml file to use  
   x : Sets project password for decryption if project is encrypted  
   v : Sets password for soapui-settings.xml file   
   D : Sets system property with name=value  
   G : Sets global property with name=value  
   P : Sets project property with name=value  
   S : Saves the project after running the mockService(s)  
   f : Sets the output folder to export results to ( soapUI Pro only )  
   o : Opens the Coverage Report in a browser (with the -g option) ( soapUI Pro only )  
   g : Sets the output to include Coverage HTML reports ( soapUI Pro only )  
</pre>
</div>

The distribution contains a mockservicerunner.bat script for running MockServices in the bin directory, for example;

	mockservicerunner.bat -m"IOrderService MockService" "C:\demo2-soapui-project.xml"

Runs the specified MockService as follows:
![alt http://www.soapui.org/Test-Automation/mock-services.html](/images/soapui.org-mockservice-starting.jpg "soapui.org mockservice starting traces")

Which can now be invoked from soapUI or any other client. Terminate the runner by pressing the return key in the console, which will shutdown as follows:

![alt http://www.soapui.org/Test-Automation/mock-services.html](/images/soapui.org-mockservice-stoping.jpg "soapui.org mockservice stoping traces")


####MockServiceRunner without X configuration####

Source:<http://www.soapui.org/forum/viewtopic.php?t=1023>
 
When trying to use mockservicerunner.sh in Linux/Solaris, you may get an error because of the X windows configuration.
 
![alt Can\'t connect to X11 window server using \'\' as the value of the DISPLAY variable. ](/images/XServer-DisplayError-1.jpg "Can't connect to X11 window server")

OR

![alt X connection to localhost:10.0 broken(explicit kill or server shutdown) ](/images/XServer-DisplayError-2.jpg "X connection to localhost:10.0 broken .")


If you want to know is how to use the mockservicerunner.sh in a manner that it does not need an X configuration.
After all, why does mockservicerunner.sh need an X configuration ? The main reason for executing it in a command line is to avoid that.
 
If you find any of the errors above adding the java.awt.headless
 
i.e  
	
	mockservicerunner.sh ../soapui-project.xml -Djava.awt.headless=true   

![alt mockservice-sucess](/images/mockservice-sucess.jpg "mockservice sucessfull after java.awt.headless option")
 
 
####Use xming, xshell to display linux gui to windows desktop (x11 forwarding)####

Source: http://www.doxer.org/learn-linux/use-xming-xshell-to-display-linux-gui-to-windows-desktop-x11-forwarding/

Download xming, install it on your windows pc system. You can go to http://sourceforge.net/projects/xming/files/ to download.

After installation xming on your windows, log in linux/solaris server 192.168.0.3. Set environment variable DISPLAY to the ip address of your windows, and append a :0 to it:

	export DISPLAY=192.168.0.4:0

Then you must allow X11 forwarding in sshd configuration file. That is, set X11Forwarding to yes in /etc/ssh/sshd_config and restart your sshd daemon.

After this, you need set 192.168.0.3(linux/solaris) to the allowed server list on your windows. Edit X0.hosts which locates at the installation directory of xming(For example, C:\Program Files\Xming\X0.hosts), add a new entry in it:192.168.0.3, the ip address of linux/solaris that you want to run x11 utility from.

Then, restart xming on your windows. And on solaris/linux server(192.168.0.3), run a X11 programe, like

	/usr/openwin/bin/xclock &

You will then see a clock gui pop up in your windows pc.

Voila, You are done.


####"All credits & kudos to the concerned websites and the users who have documented these resolutions."####


  
