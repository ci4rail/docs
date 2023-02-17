---
title: MIO03 Detailed Description
excerpt: Detailed Description of the MIO03 functionality
last_modified_at: 2022-10-28

product_name: MIO03
article_group: S103
example_device_name: MIO03-1
---

{% capture notice-text %}

Please note the following restrictions with MIO03 Revision 0:

* You cannot use MVB, CAN or RS485 interface while the USB SERVICE interface is connected! Remove the USB SERVICE interface before using the other interfaces.
* Wifi performance is not ideal and will be improved in coming revisons.

{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

## Port Reference Table

In case you want to address the services of the {{ page.product_name }} via IP:Port, you can use the following table to find the correct port number:

| Port  | Function    |
| ----- | ----------- |
| 10000 | MVB Sniffer |
| 10002 | CAN Sniffer |

{% include content/io4edge/iou03-front/detailed-description.md %}
