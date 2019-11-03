---
layout: post
title: Stylize your XML with Jquery XML Tree Plugin
description: A beatiful Jquery XML Tree script that helps you in visualising and traversing XML in tree format.
date: 2013-07-18 07:46
date_formatted: 2013-07-18 07:46
comments: true
categories: Technical
keywords: XML, XML Tree, JQUERY, Visual XML, XML Tree Plugin, search node in xml, search in xml
tags: XML, XML Tree, JQuery
---

Recently I came across a beautiful JQuery XML Tree plugin by [Mitya](http://www.mitya.co.uk/scripts/XML-Tree---visualise-and-traverse-your-XML-186)

All Credits goes to Mitya for writing the XMLTree plugin.   

The script creates the wonderful tree from a specified XML file or from manually-fed XML.
Overall this works just fine,<!--more--> When you specify an XML file as input.
Frankly? The script has few bugs:  
1. Mutliple tree on same page does not work.  
2. XML string cannot be fed manually.   

It has nice set of callback functions which can be invoked while to play with your XML Tree.

I give a small idea here but head over to 'Usage and params' section of Mitya's website for more detailed explanation.

{% codeblock initializing the XML tree %}
<div id="tree"> </div>
new XMLTree({
     fpath: '../somedir/xml.xml',
     container: '#tree'
});
{% endcodeblock %}


By default the XML will be renedered unexpanded. But You can Render the tree Fully expanded by 
giving the startExpanded option as 'true'

{% codeblock initializing the XML tree fully expanded %}
<div id="tree"> </div>
new XMLTree({
     fpath: '../somedir/xml.xml',
     container: '#tree',
     startExpanded:true
});
{% endcodeblock %}

<br />
<br />

But what if your XML is too large and you want to search any particular node or text and open only certain node and not the rest.
Well I did it as follows:

I had a search box in my page and on each key press event I am finding that particular element in the tree and expanding.
Well thats not as simple as it sounds.

Here is the snippet.
{% codeblock initializing the XML tree %}
.html file
----------
<span style="float:right">	
<b>Looking for something specific ? &nbsp;&nbsp;</b>
<input type="text" id="search_input" tabindex="-1" >
</span>

Custom.js
----------
$(document).ready(function() {
	
//LoadXML('XMLHolder','/assets/server.xml');
if ($('#tree').length > 0)
{
	var filepath = '/path to xml'

	$(function() { 
		new XMLTree({fpath: filepath, container: '#tree', startExpanded: true,
		}); 
	
		//alert ($('ul[class="xmltree startExpanded"]').length)
		$('ul[class="xmltree startExpanded"]').prop('id','xmltree');
	});
		
	jQuery.expr[':'].Contains = function(a,i,m){
	    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
	};

	//scroll to first child when filtering
	var container = $('body');
	      
	$('#search_input').focus().keyup(function(e){
	    var filter = $(this).val();
	    if (filter) {
	      $('#xmltree').find("li:not(:Contains(" + filter + "))").parent().hide();
	      $('#xmltree').find("li:Contains(" + filter + ")").parent().show();
	      $("#xmltree").find("li:Contains(" + filter + ")").children().show();
	      $('#xmltree').highlight(filter);
	      
	      //scroll to first child when filtering
	      var container = $('body');
	      var scrollTo = $('#xmltree').children().find("li:Contains(" + filter + ")").first();
	      
	      console.log(scrollTo);
	      container.scrollTop(
			    scrollTo.offset().top - container.offset().top + container.scrollTop()
			);
		  //scroll to first child when filtering- ends
	    }
	    else {
	      container.offset().top = 0;
	      $('#xmltree').find("li").children().slideDown();
	      $('#xmltree').unhighlight();
	    }
	  });
	  
	  $('#search_input').focus().keydown(function(e){
	      $('#xmltree').unhighlight();
	  });
 }
});

{% endcodeblock %}

Try it, type some thing in the box:
<span>	
<b>Looking for something specific ?</b>
<input id="search_input">
</span>


Note:
I am using the scrollTo function too, but its not working in all the browsers for some reasons.


Example:1  Using this [xml](http://www.w3schools.com/xml/simple.xml) again: Render tree unexpanded(Click on + sign to navigate).
<div id="tree2">
</div>

<script>
$(document).ready(function() {
	
//LoadXML('XMLHolder','/assets/server.xml');
if ($('#tree2').length > 0)
{

    new XMLTree({fpath: '{{ root_url }}/data/simple.xml', 
	container: '#tree2', 
	startExpanded: true
	}); 

	//alert ($('ul[class="xmltree startExpanded"]').length)
	$('ul[class="xmltree startExpanded"]').prop('id','xmltree');

		
	jQuery.expr[':'].Contains = function(a,i,m){
	    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase())>=0;
	};
	
	var container = $('body');
	var scrollTo = $('#scrollhere');
	      
	console.log(scrollTo);
	container.scrollTop(scrollTo.offset().top - container.offset().top + container.scrollTop());

	$('#search_input').keyup(function(e){
	    var filter = $(this).val();
	    //alert ("hello")
	    if (filter) {
	      $('#xmltree').find("li:not(:Contains(" + filter + "))").parent().hide();
	      $('#xmltree').find("li:Contains(" + filter + ")").parent().show();
	      $("#xmltree").find("li:Contains(" + filter + ")").children().show();
	      $('#xmltree').highlight(filter);
	      
	    }
	    else {
	      container.offset().top = 0;
	      $('#xmltree').find("li").children().slideDown();
	      $('#xmltree').unhighlight();
	    }
	  });
	  
	  $('#search_input').keydown(function(e){
	      $('#xmltree').unhighlight();
	  });
 }
});
</script>

There you have it folks.  Shoot your views in the comments, but note I document these posts for 
my reference and hope that it would help some one else too.

So cheers..

<br />
<br />
