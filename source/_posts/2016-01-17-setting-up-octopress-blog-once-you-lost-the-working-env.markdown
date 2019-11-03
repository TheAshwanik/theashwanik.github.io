---
layout: post
title: "Setting up octopress blog once you lost the working env"
description: The Post is about how to setup octopress blog once you lost it, or may be you want to blog from different computer.
date: 2016-01-17 10:01:28
date_formatted: 2016-01-17 10:01:28
comments: true
categories: Technical
tags: Octopress, repo , octopress-plugin , octopress-migration
keywords: Octopress, octopress plugin, octopress migration, octopress version update
---


Hi Guys,    

So recently I wanted to revisit my blog after a long long break, and I realized that my working blogging environment broke and I wanted to setup again to be able to blog from both my personal laptop and any other laptop. But to my dismay, it was not that stright forward. Luckily, I had the source folder of my blog with me. It was quite a feat, Hence I thought of documenting it through this post.
<!--more--> 

###How Octopress works

Octopress repositories have two branches, source and master. The `source` branch contains the files that are used to generate the blog and the `master` contains the blog itself.

When the local folders are initially configured according to the [Octopress Setup Guide](http://octopress.org/docs/setup/), the master branch is stored in a subfolder named ‘_deploy’. Since the folder name begins with an underscore, it is ignored when you git push origin source. Instead, the master branch (which contains your blog posts) gets updated when you rake deploy.


###Clone your blog to the new machine

{% codeblock %}
$ git clone -b source git@github.com:username/username.github.com.git Local_octopress
$ cd Local_octopress
$ git clone git@github.com:username/username.github.com.git _deploy 
$ gem install bundler
$ rbenv rehash    # If you use rbenv, rehash to be able to run the bundle command

$ bundle install

$ rake setup_github_pages

It will prompt you for your repository URL.
Enter the read/write url for your repository
(For example, 'git@github.com:your_username/your_username.github.com)
That’s you setup with a new local copy of your Octopress blog.

{% endcodeblock %}

###Pushing changes from two different machines

{% codeblock %}
If you want to blog from more than one computer, you need to make sure that you push everything before switching computers. 
From the first machine do the following whenever you’ve made changes:

$ rake generate
$ git add .
$ git commit -am "Some comment here." 
$ git push origin source  # update the remote source branch 
$ rake deploy             # update the remote master branch


Then on the other machine, you need to pull those changes.

$ cd octopress
$ git pull origin source  # update the local source branch
$ cd ./_deploy
$ git pull origin master  # update the local master branch

{% endcodeblock %}


###Octopress 2.0
If you were returning to blogging after so long, chances are that there were many things [changed](https://github.com/imathis/octopress/blob/master/CHANGELOG.markdown).

1.  Rubypants is removed.
2.  Include Code Tag lets you embed external code snippets from your file system and adds a download link
3.  Pullquote Tag Generate beautiful semantic pullquotes (no double data) based on Maykel Loomans's technique
4.  Category Generator gives you archive pages for each category
5.	Sitemap.xml Generator for search engines

etc. etc.

I got so many errors once I checked out a new version of Octopress. It was not supporting many of my old plugins, So I got rid of some, and I updated some.


###Errors
One error I got was in date.rb of [feedjira(formerly feedzira)](http://feedjira.com/) plugin.
The error message said:  

{% codeblock %}
jekyll 2.1.1 undefined method `deep_merge'
{% endcodeblock %}


so I replaced deep_merge 

{% codeblock %}
    def to_liquid
  		date_format = self.site.config['date_format']
		self.data.deep_merge({
			"title"             => self.data['title'] || self.slug.split('-').select {|w| w.capitalize! || w }.join(' '),
			"url"               => self.url,
			"date"              => self.date,
			# Monkey patch
			"date_formatted"    => format_date(self.date, date_format),
			"updated_formatted" => self.data.has_key?('updated') ? format_date(self.data['updated'], date_format) : nil,
			"id"                => self.id,
			"categories"        => self.categories,
			"next"              => self.next,
			"previous"          => self.previous,
			"tags"              => self.tags,
			"content"           => self.content })
	end

{% endcodeblock %}


with the following: 


{% codeblock %}
    def to_liquid(attrs = nil)
      date_format = self.site.config['date_format']
      new_datas = {
        "title"             => self.data['title'] || self.slug.split('-').select {|w| w.capitalize! || w }.join(' '),
        "url"               => self.url,
        "date"              => self.date,
        # Monkey patch
        "date_formatted"    => format_date(self.date, date_format),
        "updated_formatted" => self.data.has_key?('updated') ? format_date(self.data['updated'], date_format) : nil,
        "id"                => self.id,
        "categories"        => self.categories,
        "next"              => self.next,
        "previous"          => self.previous,
        "tags"              => self.tags,
        "content"           => self.content }
     
      Utils.deep_merge_hashes(self.data, new_datas)
    end
{% endcodeblock %}

Notice the use of deep_merge_hashes above.


Another error was `Updates were rejected because the tip of your current branch is behind` when I executed "bundle exec rake gen_deploy"

The reason is that Octopress only does a push to the `master` branch and not a pull. To resolve this, do this:

{% codeblock %}
$$ cd _deploy
$$ git push origin master -f   # hope this solves the problem, move to next command
$$ cd ..
$$ bundle exec rake gen_deploy
{% endcodeblock %}

Another error was in installing curl on windows. So I had to refer [this](https://github.com/taf2/curb/issues/37)
And install curb manually.

{% codeblock %}
C:\Users\AshwaniK> gem install curb  -v '0.7.18' -- --with-curl-lib=C:\libcurl\bin --with-curl-include=C:\libcurl\include
Temporarily enhancing PATH to include DevKit...
Building native extensions with: '--with-curl-lib=C:\libcurl\bin --with-curl-include=C:\libcurl\include'
This could take a while...
Successfully installed curb-0.7.18
Installing ri documentation for curb-0.7.18
1 gem installed
{% endcodeblock %}



Reference Commands:
{% codeblock %}
cd octopress
bundle exec rake new_post["title"]
bundle exec rake preview
bundle exec rake generate

bundle exec rake deploy

git add .
git commit -m 'site updated'
git push origin source
{% endcodeblock %}


There were other errors which I somehow resolved.

Hope this helps someone.  I might need this again, So I am keeping a refrence.

Thats all folks. Chow.


Credits to:
1.	[Trouble-with-cloning-octopress-blog-on-other-laptops](http://stackoverflow.com/questions/15864872/trouble-with-cloning-octopress-blog-on-other-laptops-computers-conflict-isseue)     
2.	[Clone Your Octopress to Blog From Two Places.](http://blog.zerosharp.com/clone-your-octopress-to-blog-from-two-places/)     
3.	[Blogging-with-octopress-from-2-computers/](http://blog.mohitkanwal.com/blog/2014/03/26/blogging-with-octopress-from-2-computers/)     


