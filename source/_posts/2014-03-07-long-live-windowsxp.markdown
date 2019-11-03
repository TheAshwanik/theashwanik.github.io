---
layout: post
title: "Long Live WindowsXp/Run XP in a Virtual Box for free"
description: Windows XP Support Ends in April 2014, but here is how you can still make use of it by running Windows XP in a Virtual Box
date: 2014-03-07 23:25
date_formatted: 2014-03-07 23:25
comments: true
categories: Technical
tags: windowsxp
keywords: windows-xp, windows xp support, windows xp support end date, windows xp support ends,Running Windows XP in a Virtual Box
---

The long loved , super user friendly Operating System's Life is going to see the last light in few days.   
Windows XP, the cornerstone of most PC users for the past 10+ years, is being officially phased out.
<!--more-->

<iframe class="restricted" scrolling="no" src="http://support.microsoft.com/lifecycle/?LN=en-ie&c2=1173#tableContainer" width=105% height="370" frameborder="1"></iframe>

We all loved Windows XP. Although you can still run XP on your PCs , laptops but at your own risks.
Microsoft has publicly stated that no new patches will be released for the OS after April 2014 (outside of very critical security flaws found.)


If in case you love Windows-7 more , but wanna use Windows-XP as well , then read on..

####Running Windows XP in a Virtual Box for free


#####Follow the steps:

1.    Download [Windows XP Mode](http://www.microsoft.com/windows/virtual-pc/download.aspx) (WindowsXPMode_en-us.exe | MD5: bf3726d684d3acb98185665123c9efcf)
2.    Extract xpm from WindowsXPMode_en-us.exe with a file archiver 7-Zip etc.
3.    Add .rar extension to xpm
4.    Extract VirtualXPVHD from xpm.rar
5.    Add .vdi extension to VirtualXPVHD
6.    Create new machine in VirtualBox, specifying VirtualXPVHD.vdi as the hard disk
7.    Once initial setup is complete, uninstall Virtual PC Integration Components from Add/Remove Control Panel
8.    Install Guest Additions (Devices > Install Guest Additions...) 

  
Once you start the Virtual Box, you will be asked to activate windows-xp. But wait, I do not have activation code, I thought this process was for free.
Hold on, don't jump your horses..Follow the next steps.


9.    Shut down virtual machine
10.   Download pcbios.bin (MD5: 12ccdc652b30c6d1e307c6f7deff5d24) from [VMLite](http://www.vmlite.com/index.php?option=com_kunena&Itemid=158&func=view&catid=9&id=6706&limit=6&limitstart=12#8420) and copy to a directory on host computer (e.g., C:\vm\)
11.   Run the command: "C:\Program Files\Oracle\VirtualBox\VBoxMange.exe" setextradata vm-name "VBoxInternal/Devices/pcbios/0/Config/BiosRom" "c:\vm\pcbios.bin"

<br/>

####Notes:

<p class="mynotice">While a virtual machine created in this manner should run under any OS X, Linux, or Windows host, running under anything but Windows 7 Professional, Enterprise, 
or Ultimate would apparently violate the Windows XP Mode EULA:
You may install, use, access, display and run one copy of the Software in a single virtual machine on a single computer, such as a workstation, terminal or other device ("Workstation Computer"), 
that contains a licensed copy of Windows 7 Professional, Enterprise or Ultimate edition. Virtualization software is required to use the Software on the Workstation Computer ... 
If you are using the Software with a properly licensed copy of Windows 7 Professional, Enterprise or Ultimate, activation of the Software is not required.
</p>
More Info on this can be found [here](http://social.technet.microsoft.com/Forums/windows/en-US/8b1bfa74-15e0-4ce2-8612-f6eaf2cf25ab/is-it-ok-to-use-xp-mode-vhd-in-virtualbox-without-a-license-using-vmlite-xp-mode-plugin?forum=w7itprovirt)



#####Sources:
[www.technibble.com](http://www.technibble.com/windows-xp-support-ends-in-april-2014-what-technicians-need-to-know/)    
[tinyapps](http://tinyapps.org/blog/windows/201210210700_xp_mode_virtualbox.html)

<br/>
