---
title: IOU06 Quick-Start-Guide / Binary Output Demo
excerpt: IOU06 extension module Binary Output Quick Start
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou06/detailed-description/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary outputs and how to acknoledge it's work.
{% include content/io4edge/quick-start/intro1.md %}
* A laboratory Power Supply capable of supplying 24V/100mA.

{% include content/io4edge/quick-start/intro2.md %}

{% if is_iou %}
| Service Name                        | Description                       | Port  |
| ----------------------------------- | --------------------------------- | ----- |
| {{ page.example_device_name }}      | Core function                     | 9999  |
| {{ page.example_device_name }}-ibis | IBIS                              | 10000 |
| {{ page.example_device_name }}-com  | COM (mutually exclusive with CAN) | 10001 |
| {{ page.example_device_name }}-can  | CAN (mutually exclusive with COM) | 10001 |
| {{ page.example_device_name }}-gpio | Binary Outputs                    | 10002 |

We need this service address in the demo programs to address the module, for example to address the binary output function, we would use `{{ page.example_device_name }}-gpio`.

{% include content/io4edge/quick-start/intro3.md %}
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
S101-IOU01-USB-EXT-1, 192.168.201.1, S101-IOU01, <serial-number>
+-----------------------------+-------------------------------------+-------+
|        SERVICE TYPE         |            SERVICE NAME             | PORT  |
+-----------------------------+-------------------------------------+-------+
| _ttynvt._tcp                | S101-IOU06-USB-EXT-1-ibis           | 10000 |
| _ttynvt._tcp                | S101-IOU06-USB-EXT-1-com            | 10001 |
| _io4edge_binaryIoTypeB._tcp | S101-IOU06-USB-EXT-1-gpio           | 10002 |
+-----------------------------+-------------------------------------+-------+
```
{% endif %}

## Binary I/O Demo

{% assign example_name="set_outputs" %}
{% assign example_path="gpio" %}
{% assign example_service_ext="gpio" %}
{% assign example_service_name = page.example_device_name | append: "-gpio" %}

The Binary output demo will stimulate the binary outputs of the {{ page.product_name }}. Please connect separate loads to the binary  e.g. 1000Ohm resistance, so when the output switch turns on, the binary output will act as a switch, closing the circuit, allowing current to flow through the load.



### Connecting

Connect the binary output pins `BIN_OUT1` & `BIN_OUT2` to different loads, which are supplied with 24V. Connect the ground to the Common Ground pin `COMMON_GND`



![Connection for Binary Output Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/use-case-iou06-output.svg' | relative_url }})

{% include content/io4edge/io4edge-go-example.md %}
