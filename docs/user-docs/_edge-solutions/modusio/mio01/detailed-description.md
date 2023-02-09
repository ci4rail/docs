---
title: MIO01 Detailed Description
excerpt: Detailed Description of the MIO01 functionality
last_modified_at: 2022-08-12

product_name: MIO01
article_group: S103
example_device_name: MIO01-1
---
{% capture notice-text %}

Please note the following restrictions with MIO01 Revision 00:

* Do not connect USB Service interface when you want to use analog1 channel!
* Wifi performance is not ideal

Both issue are fixed in Revision 01.

{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

{% include content/io4edge/iou01-front/detailed-description.md %}
