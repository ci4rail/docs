{% if tabs_index == 0 %}
  {% assign active = "active" %}
{% else %}
  {% assign active = "" %}
{% endif %}

  <div class="tab-pane fade in {{ active }}" id="{{ tabs[tabs_index] }}Id{{ tabs_instance }}" role="tabpanel" markdown="1">

{% assign tabs_index = tabs_index | plus: 1 %}
