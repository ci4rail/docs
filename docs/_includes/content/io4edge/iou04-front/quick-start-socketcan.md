
# SocketCAN Demo

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo is using the Linux [SocketCAN framework](https://www.kernel.org/doc/html/latest/networking/can.html).

## Prerequisites

### Hardware
{% if is_iou %}
* A Moducop Edge Computer with a {{ page.product_name }} installed
* A development PC (Windows or Linux), connected via Network to the Moducop{% else %}
* A target machine running Linux that is in the same network as your {{ page.product_name }}
* A development PC (Windows or Linux), connected via Network to the target machine{% endif %}
* CANbus with at least one CAN device
* Cable to connect the CAN device with the {{ page.product_name }}

{% if is_iou %}

### Determine the Service Address of your {{ page.product_name }}
Io4Edge Devices are usually addressed by their service address, which is a name in the network.

The {{ page.product_name }}'s service name depends on the ModuCop's slot and is usually
`{{ full_product_name }}-USB-EXT-<slot-number>[-<function>]`, i.e. if the {{ page.product_name }} is in the slot next to ModuCops CPU01, we have the following service names:
{% endif %}
{% if is_iou %}
| Service Name                        | Description   |
| ----------------------------------- | ------------- |
| {{ page.example_device_name }}      | Core function |
| {{ page.example_device_name }}-com1 | COM1          |
| {{ page.example_device_name }}-com2 | COM2          |
| {{ page.example_device_name }}-can  | CAN           |

{% include content/io4edge/quick-start/intro3.md %}
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
S101-IOU04-USB-EXT-1, 192.168.201.1, S101-IOU04, <serial-number>
+---------------------+---------------------------+-------+
|    SERVICE TYPE     |       SERVICE NAME        | PORT  |
+---------------------+---------------------------+-------+
| _ttynvt._tcp        | S101-IOU04-USB-EXT-1-com1 | 10000 |
| _ttynvt._tcp        | S101-IOU04-USB-EXT-1-com2 | 10001 |
| _io4edge_canL2._tcp | S101-IOU04-USB-EXT-1-can  | 10002 |
+---------------------+---------------------------+-------+
```
{% endif %}
