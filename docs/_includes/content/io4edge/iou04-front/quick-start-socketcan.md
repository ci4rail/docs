
# SocketCAN Demo

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo is using the Linux [SocketCAN framework](https://www.kernel.org/doc/html/latest/networking/can.html).

{% include content/io4edge/quick-start/intro1.md %}
* CANbus with at least one CAN device
* Cable to connect the CAN device with the {{ page.product_name }}

{% include content/io4edge/quick-start/intro2.md %}
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

{% assign example_name="streamDump" %}
{% assign example_path="canL2" %}
{% assign example_service_name = page.example_device_name | append: "-can" %}

{% include content/io4edge/iou04-front/can-config-connect.md %}

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

Now you should see all frames that are sent on the CAN bus

**TODO**
```
Started stream
got stream data with 0 samples
got stream data with 0 samples
got stream data with 0 samples
got stream data with 0 samples
```
