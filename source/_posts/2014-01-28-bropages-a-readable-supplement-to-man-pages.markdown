---
layout: post
title: "BroPages a readable supplement to man pages"
description: "bro pages are a highly readable supplement to man pages. bro pages show concise, common-case examples for Unix commands"
date: 2014-01-28 08:31
date_formatted: 2014-01-28 08:31
comments: true
categories: Technical
tags: Shell,Commands
keywords: Shell Commands, man pages, bro pages, Shell Commands man pages, commands, Shell commands explained with example, man pages commands explanation.
---


A little while ago , I shared an amazing tool with all of you , [Explain Shell](http://blog.ashwani.co.in/blog/2013-12-03/shell-commands-explained-like-never-before/).

Today I came across another good resource for the *nix programmers. And it's called , [bro pages](http://bropages.org/). 
Just like man pages,but with readable examples to the commands.
<!--more-->
Have a look at the following example command from your terminal, after you install bro pages.

<pre>
		Command#> bro tar
		# Create a tar archive
		tar -cf archive.tar file1 file2 ... fileN
		
		# Create a tar gzipp'd archive
		tar -zcf archive.tar.gz file1 file2 ... fileN
		
		# Create multi-part tar archives from a directory
		tar cf - /path/to/directory|split -b<max_size_of_part>M - archive.tar
		
		# Extract all files from a tar archive
		tar -xf archive.tar
		
		# Extract all files from a tar gzipped archive
		tar -zxf archive.tar.gz
		
		# Extract one file from a tar archive
		tar -xf archive.tar the_one_file
		
		# Lists all files in a tar archive
		tar -tf archive.tar
</pre>


You can find more examples [here](http://bropages.org/browse).   

 
Or better why don't you install it and give a try. 
Installation is super easy with just one command:
	"gem install bropages"
	
	
You need Ruby 1.8.7+ installed on your machine though for this to work.


You can add your own examples of commands to bro pages by using:
	bro add curl
	
You can vote up and down for the commands examples by using:
	bro thanks      to upvote (2)
    bro ...no       to downvote (0)
This way, people will see the most rates command examples first with highest votes. 

I personally feel, this is a good idea. You should also check it out.

That all folks.

Thanks for reading this far.





