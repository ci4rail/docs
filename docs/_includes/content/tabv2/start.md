{% assign tabs = include.tabs | split: ", " %}

{% assign tabs_instance = tabs_instance | default: 0 %}
{% assign tabs_instance = tabs_instance | plus: 1 %}

{% assign tabs_index = 0 %}

{% assign tab = tabs[0] %}
<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#{{ tab }}Id{{ tabs_instance }}" role="tab" >{{ tab }}</a></li>
{% for tab in tabs offset:1 %}
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#{{ tab }}Id{{ tabs_instance }}" role="tab" >{{ tab }}</a></li>
{% endfor %}
</ul>
<div class="tab-content">
{% include content/tabv2/_entry-start.md %}
