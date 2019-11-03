---
layout: post
title: "Shell Commands explained like never before"
description: Shell Commands are explained in a beautiful visual representation.
date: 2013-12-03 21:27
date_formatted: 2013-12-03 21:27
comments: true
categories: Technical
tags: Shell,Commands
keywords: Shell Commands, Shell Commands explained, commands, Shell commands explained visually, Visual Shell commands explanation
---

Idan Kamara has came up with a very intriguing and useful tool [Explain Shell](http://explainshell.com/). He has created a cool web app which explains any Shell Command visually.
You give a shell command and it will tell you what the each option does.  This makes understanding the complex looking commands very easier.
<!--more-->

{% img  /assets/ExplainShell-1.JPG 800 600 "Explain Shell" "Explain Shell Image" %}


<br />
<hr />
It becomes a bit tedious for a very long complex command like [this](http://explainshell.com/explain?cmd=ps+x+-o++%22%25r+%25c+%22+|+grep+%22webLauncher.sh%22+|+awk+-F%27+%27+%27{print+%241}%27+|+xargs+-I+%25+%2Fbin%2Fkill+-TERM+--+-%25) though.
But I would overlook that given the awesomeness of this tool and the fact that you can click on the commands to get the MAN pages helps.  

For e.g. If you click on tar as in the following screenshot, you will get the MAN pages of tar.
{% img /assets/ExplainShell-2.JPG 800 600 "Explain Shell" "Explain Shell tar command Image" %}
<hr />
{% img /assets/ExplainShell-3.JPG 800 600 "Explain Shell" "Explain Shell Man Page Image" %}
<hr />
**Positives**
<hr />

1.  Its Open-source. Find the source code [here](https://github.com/idank/explainshell)
1.  It has simple beautiful interface.
1.  You can log issues [here](https://github.com/idank/explainshell/issues)

<hr />
**Negatives**
<hr />
I don't Mind any.  :)  


I hope this would help many of us.  Kudos and my best wishes to the developer.   
<br /> 
-Ashwani Kumar Via [HackerNews](https://news.ycombinator.com/item?id=6834791)  
<br />


