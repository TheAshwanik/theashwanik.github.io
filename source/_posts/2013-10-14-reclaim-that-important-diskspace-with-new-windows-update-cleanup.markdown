---
layout: post
title: "Reclaim that important diskspace with New Windows Update Cleanup"
description: How To clean up wasted diskspace caused by numerous windows updates over the years.
date: 2013-10-14 08:35
date_formatted: 2013-10-14 08:35
comments: true
categories: [General,Technical]
tags: windows,cleanup
keywords: Windows update cleanup, new windows update cleanup, reclaim diskspace, cleanup diskspace, cleanup windows update diskspace
---

Yippee !

Finally Microsoft has released a very important update package.

Remember, how we used to despise the windows updates and security patches eating up our diskspace. And many a times, we even used to skip
the update with the feeling of satisfaction (just saved a lot of diskspace) <!--more--> and dissatisfaction (what if it included a critical patch).

Well, Not anymore! We don't have to be in dilemma anymore. Since, Microsoft has released a very important update this time, with which we can cleanup the
otherwise outdated windows update files.

This release is for Windows 7 SP1 machines, KB [2852386](http://support.microsoft.com/kb/2852386) adds the ability to cleanup all the obsolete updates in the WinSxS folder. 


{% blockquote %}
Windows Updates can be terrible space hogs. Windows saves every security update and hotfix—even if 
they are superseded by new updates—in the WinSxS directory. You cannot just manually delete everything in that folder,because some files are needed just in case a system file gets corrupted or you need to roll back a Windows Update. - Life Hacker
{% endblockquote %}

A new  recommended update was released. It can be found [Here](http://support.microsoft.com/kb/2852386).

<b>Note: that this is categorized as an “important” update. 
This means it’s not a critical security update which means it may not be automatically installed or deployed depending on your 
Windows Update settings, WSUS settings, or other 3rd party patch management software settings.</b>



Via - [Breaking News! Reduce the size of the WinSxS Directory and Free up Disk Space with a New Update for Windows 7 SP1 Clients](http://blogs.technet.com/b/askpfeplat/archive/2013/10/07/breaking-news-reduce-the-size-of-the-winsxs-directory-and-free-up-disk-space-with-a-new-update-for-windows-7-sp1-clients.aspx)
