---
layout: post
title: "Search string faster with Ruby"
description: "Search for a string in large files with ruby at ease, as against to grep which takes lot of time to do the same job."
date: 2018-07-20 15:59
date_formatted: 2018-07-20 15:59
comments: true
categories: Technical
keywords: Slow grep, Ruby, Search with Ruby, Search String, Grep String in file, ruby one liner, ruby command to search string, search string using ruby, search string with ruby command
tags: grep, ruby, shell script
---

Is grep Slow?   Sure it is. Read on..
Just a few days back there was an electrical outage and lot of applications were dead.   
In one case, lot of customer orders could   <!--more--> not be processed.
Hence, there rose a need of manual intervention and extraction of orders (XML) from a logfile and re-feeding them to another system.
The task was simple, I had order numbers in orders.txt  and I had to write a shell script to grep for a particular 
xml containing each of these orders, extract XML and create a file for each order.

{% codeblock Shell script to loop and find an order in another file%}
cat extract.sh
--------------
i=0
echo "Extraction Script Started at:" `date`
while read order_id; do
 	filename=$order_id"_tmp.xml"
 	finalfilename=$order_id".xml"
	grep ".*$order_id." *.log > $filename && echo "written xml for $order_id in $filename" || echo $order_id >> Orders_not_found.txt
	cat $filename | sed -e 's|text-to-remove|new-text|g' | sed -e 's|\*\*\*||g' > $finalfilename
	rm $filename
	((i++))
done < orders.txt
echo "Extraction Script Ended at:" `date`
{% endcodeblock %}

But the problem was that the log file in which I was searching was too huge. It was 5GBs in total.
Hence the grep was taking minimum 4-5 Minutes to search one order and create an xml file for that. 
Clearly this was not a solution, as I had to find thousand orders in those log files and it was very critical for end customer.   

If my calulation was right, I had to spend:    
4 Mins = 1 Xml    
60 Mins = 1 Hr = 15 Xml    
at this rate I would have spent atleast 3-4 days CPU time , to get all those 1000 XMLs. 
(Not to mention the pain of getting screwed and frustration). Meaning which, we all would have been screwed 
over and over again for 3-4 days by the customer.    

<b>Enter Ruby:</b>
One liner saved us.    
I used this ruby command, to first find the relevant generic string then create order xml files using a normal shell
script as above. I thought I would keep this fir future reference.

{% codeblock %}
$ ruby -pe 'next unless $_ =~ /<RegExp for stringtomatch>.*Number.*/' < 5GB-file.log >> 6Mb-file-reduced.log
{% endcodeblock %}

Wondereful, Ruby took just few minutes to grep the regular exp string into a 5GB log file, and now I had to search orders 
into this smaller reduced size intermediate file.

Thus, this saved us 3 days and did wonders in just half an hour.

Voila !!!

Credit for the one liner goes to [Garry Tan](http://axonflux.com/handy-ruby-one-liners-by-david-thomas), where I found this wonderful ruby command.
