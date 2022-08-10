---
title: IOU04 Quick-Start-Guide / CAN API Demo
excerpt: Quick startup with IOU04 extension module
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou04/detailed-description/
product_name: IOU04
article_group: S101
example_device_name: S101-IOU04-USB-EXT-1

---
# CAN Demo using Io4Edge API

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo directly accesses the {{ page.product_name }} via the Io4Edge API.

{% include content/io4edge/quick-start/intro1.md %}
* Another CAN device

{% include content/io4edge/quick-start/intro2.md %}
| Service Name                    | Description   |
| ------------------------------- | ------------- |
| {{ mdns_service_address }}      | Core function |
| {{ mdns_service_address }}-com1 | COM1          |
| {{ mdns_service_address }}-com2 | COM2          |
| {{ mdns_service_address }}-can  | CAN           |

{% include content/io4edge/quick-start/intro3.md %}


{% assign example_name="streamDump" %}
{% assign example_path="canL2" %}
{% assign example_service_ext="can" %}


# Bus Configuration



### Connecting

Connect CAN_L, CAN_H and GND_ISO to the CAN bus. Be sure to have correct termination at each end of the cable. For details, see TODO.

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}
