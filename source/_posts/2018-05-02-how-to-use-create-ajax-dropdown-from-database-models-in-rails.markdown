---
layout: post
title: "How to use create ajax dropdown from database models in Rails"
description: How to use create ajax dropdown from database models in Rails
date: 2018-05-02 20:17
date_formatted: 2018-05-02 20:17
comments: true
categories: [Technical]
tags: ajax, rails, dropdown
keywords: 
---

This post is about quick demo of Ajax based dropdown in rails.
The dropdown fetches the data from a collection in database.   

<!--more-->


### index.html.erb
----

{% codeblock %}
<div>
<%= f.collection_select :vertical, @verticals, :vertical, :vertical, {:prompt => "Select a Vertical"}, {:class => "dropdown_vertical btn btn-default dropdown-toggle"} %>

<%= f.collection_select :subVertical, @subVerticals, :subVertical, :subVertical, {:prompt => "Select a Sub Vertical"}, {:class => "dropdown_subVertical btn btn-default dropdown-toggle"} %>

</div>
{% endcodeblock %}

### custom.js
----

{% codeblock %}
$("#search_vertical").on('change', function(){
var listitems = [];

$.ajax({
      url: "populate_subVerticals",
      type: "GET",
      data: {vertical_name: $(this).val()},
      success: function(data) {
      $("#search_subVertical").children().remove();
      $("#search_subVertical").append('<option value=>' + "Select a Sub Vertical" + '</option>');
      $.each(data,function(key, value) 
      {
      listitems += '<option value="' + value.subVertical + '">' + value.subVertical + '</option>';
      });

      $("#search_subVertical").append(listitems);

      }
	})
});

{% endcodeblock %}


### Controller 
----

{% codeblock %}
def populate_subVerticals
    vertical_name = params[:vertical_name]
    @verticals = Vertical.where(:vertical => vertical_name).select("id","subVertical").all
    respond_to do |format|
      format.json { render json: @verticals }
    end
  end

{% endcodeblock %}



### routes.rb file 
----

{% codeblock %}
get 'populate_subVerticals', to: 'verticals#populate_subVerticals'
{% endcodeblock %}

----  

That's it folks.



