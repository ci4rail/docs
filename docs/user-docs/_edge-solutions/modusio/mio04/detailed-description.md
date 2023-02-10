---
title: MIO04 Detailed Description
excerpt: Detailed Description of the MIO04 functionality
last_modified_at: 2022-08-09

product_name: MIO04
article_group: S103
example_device_name: MIO04-1
---

{% capture notice-text %}

Please note the following restrictions with MIO04 Revision 00:

* Do not connect USB Service interface when you want to use COM Port RTS, CTS lines, or when using half-duplex mode!
* Wifi performance is not ideal and will be improved in coming revisons

{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

## Port Reference Table

In case you want to address the services of the {{ page.product_name }} via IP:Port, you can use the following table to find the correct port number:

| Port  | Function |
| ----- | -------- |
| 10000 | COM1     |
| 10001 | COM2     |
| 10002 | CAN      |


{% include content/io4edge/iou04-front/detailed-description.md %}
