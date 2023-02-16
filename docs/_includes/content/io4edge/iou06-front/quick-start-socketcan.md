# SocketCAN Demo

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo is using the Linux [SocketCAN framework](https://www.kernel.org/doc/html/latest/networking/can.html).

**Warning** On the the {{ page.product_name }}, the CAN and COM ports **cannot be used at the same time**. To enable CAN, set a *persistent* [bus configuration]({{ '#busconfiguration' }}). If you want to use the COM ports, remove the persistent bus configuration.
{: .notice--warning}

{% include content/io4edge/quick-start/intro1.md %}
* CANbus with at least one CAN device
* Cable to connect the CAN device with the {{ page.product_name }}



{% include content/io4edge/iou06-front/can-config-connect.md %}

### Create a socketCAN instance

To access the {{ page.product_name }} via socketCAN, we create a virtual socketCAN network that matches the service name of your {{ page.product_name }} CAN Interface.

The virtual socket CAN network must be named according to {{ page.product_name }} CAN Interface service name. E.g. if the service name is `MYDEV-can`, the virtual socketCAN device must be named `vcanMYDEV` (without -can). Because network interface names can have only max. 15 characters, but service names can be longer, there is a rule to map longer service names to socketCAN device names:

`vcan<first-4-chars-of-service-name>xx<last-5-chars-of-service-name>`

 Examples:

* Service Name `S101-IOU06-USB-EXT-1-can` -> vcan name `vcanS101xxEXT-1`
* Service Name `123456789012-can` -> vcan name `vcan1234xx89012`
* Service Name `MIO04-1-can` -> vcan name `vcanMIO04-1`


Now, create a virtual socketCAN network. On your {{ target_name }}, execute:
```bash
ip link add dev {{ page.socketcan_name }} type vcan
ip link set up {{ page.socketcan_name }}
```

### Function Test

Using the `candump` tool (part of `can-utils` package), you should see all frames that are sent on the CAN bus. Example (would dump also error information from CANbus):

```
./candump {{ page.socketcan_name }} {{ page.socketcan_name }},1FFFFFFF:1FFFFFFF,#FFFFFFFF -e
  {{ page.socketcan_name }}  6B6   [5]  37 67 2F 0F F2
  {{ page.socketcan_name }}  24A   [6]  B1 39 8A 3A A5 77
  {{ page.socketcan_name }}  57C   [5]  01 B2 9F 37 22
  {{ page.socketcan_name }}  665   [8]  1C C2 60 0A 8E E3 85 42
  {{ page.socketcan_name }}  18B   [5]  B0 E5 E4 2E 24
  {{ page.socketcan_name }}  0D0   [8]  64 49 45 71 6B B2 6E 09
  {{ page.socketcan_name }}  146   [7]  2E A6 CF 44 1A E9 2A
  {{ page.socketcan_name }}  508   [0]
  {{ page.socketcan_name }}  726   [8]  B0 B5 2E 62 70 89 78 4F
  {{ page.socketcan_name }}  454   [2]  15 01
```
