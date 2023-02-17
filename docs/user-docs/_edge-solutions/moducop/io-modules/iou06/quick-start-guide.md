---
title: IOU06 Quick-Start-Guide
excerpt: Quick startup with IOU06 extension module

custom_next: /edge-solutions/moducop/io-modules/iou06/detailed-description/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

In this quick-start guide we will show the basic functions of the {{ page.product_name }}.

For most functions, you need the service address of the {{ page.product_name }}.

{% include content/io4edge/quick-start/prepare.md %}
{% include content/io4edge/quick-start/determine-service-address.md %}
{% if is_iou %}
| Service Name                        | Description                       | Port  |
| ----------------------------------- | --------------------------------- | ----- |
| {{ page.example_device_name }}      | Core function                     | 9999  |
| {{ page.example_device_name }}-ibis | IBIS                              | 10000 |
| {{ page.example_device_name }}-com  | COM (mutually exclusive with CAN) | 10001 |
| {{ page.example_device_name }}-can  | CAN (mutually exclusive with COM) | 10001 |
| {{ page.example_device_name }}-gpio | Binary Outputs                    | 10002 |
{% include content/io4edge/quick-start/intro3.md %}
{% endif %}


## IBIS

* [How to find IBIS tty device]({{ '/edge-solutions/moducop/io-modules/iou06/quick-start-ibis' | relative_url }})

## CAN

* [CAN Demo using Io4Edge API]({{ '/edge-solutions/moducop/io-modules/iou06/quick-start-can-io4edge' | relative_url }})

* [SocketCAN Demo]({{ '/edge-solutions/moducop/io-modules/iou06/quick-start-socketcan' | relative_url }})

## RS422/485

* [Serial Port Demo]({{ '/edge-solutions/moducop/io-modules/iou06/quick-start-serial' | relative_url }})

## Audio

* [Audio Demo]({{ '/edge-solutions/moducop/io-modules/iou06/quick-start-audio' | relative_url }})

## Binary Outputs
