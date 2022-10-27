{% assign target_name ="Moducop" %}

In this quick-start guide we will run demo programs that dump the frames on the MVB and CAN bus {{ page.product_name }} to the console.
{% include content/io4edge/quick-start/intro1.md %}
For MVB Demo:
* MVB bus with at least a Master and a Slave

For CAN Demo:
* CANbus with at least two CAN devices
* Cable to connect the CAN device with the {{ page.product_name }}

{% include content/io4edge/quick-start/intro2.md %}

{% if is_iou %}
| Service Name                              | Description   |
| ----------------------------------------- | ------------- |
| {{ page.example_device_name }}            | Core function |
| {{ page.example_device_name }}-mvbSniffer | MVB function  |
| {{ page.example_device_name }}-can        | CAN function  |

We need this service address in the demo programs to address the module, for example `{{ page.example_device_name }}-mvbSniffer`.

{% include content/io4edge/quick-start/intro3.md %}
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
S101-IOU03-USB-EXT-1, 192.168.201.1, S103-IOU01, <serial-number>
+-----------------------------+---------------------------------+-------+
|        SERVICE TYPE         |            SERVICE NAME         | PORT  |
+-----------------------------+---------------------------------+-------+
| _io4edge_mvbSniffer._tcp    | {{ page.example_device_name }}-mvbSniffer | 10000 |
| _io4edge_canL2._tcp         | {{ page.example_device_name }}-can        | 10001 |
+-----------------------------+---------------------------------+-------+
```
{% endif %}

## MVB Demo with Simulated Frames

{% assign example_name="stream" %}
{% assign example_path="mvbSniffer" %}
{% assign example_service_ext="-mvbSniffer" %}
{% assign example_service_name = page.example_device_name | append: example_service_ext %}

The MVB loop demo will use the {{ page.product_name }} internal MVB frame generator to simulate frames on the MVB. The generated frames do not leave the {{ page.product_name }}. They are internally looped back in the  {{ page.product_name }}.

The demo then dumps the *simulated* received frames to the console.

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} -gen {{ example_service_name }}
```

You should see an output like this:
```
Started stream
dt=0 addr=000123, kProcessData32Bit, data=01 02 03 04 ,
dt=288 addr=000456, kProcessData16Bit, data=aa bb ,
dt=877 addr=000123, kProcessData32Bit, data=01 02 03 04 ,
dt=288 addr=000456, kProcessData16Bit, data=aa bb ,
dt=877 addr=000123, kProcessData32Bit, data=01 02 03 04 ,
dt=288 addr=000456, kProcessData16Bit, data=aa bb ,
dt=877 addr=000123, kProcessData32Bit, data=01 02 03 04 ,
dt=288 addr=000456, kProcessData16Bit, data=aa bb ,
...
```

## Receive from a Real MVB

To receive frames from the MVB, connect the {{ page.product_name }} to a real MVB. The MVB bus is connected to the {{ page.product_name }} via the two connectors labelled `MVB1` and `MVB2`.

### Connecting

MVB may be EMD or ESD. Depending on the position of the {{ page.product_name }} in the bus, connect it like in the following drawing:

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou03/iou03_mvb_qs.svg' | relative_url }})

### Demo Software

Run the same demo software as in the previous section, but *don't* specify the `-gen` flag.

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

Then the tool should dump all telegrams on the bus to the console.

## CAN Demo using the Io4Edge API

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo directly accesses the {{ page.product_name }} CAN interface via the Io4Edge API.

{% assign example_name="streamDump" %}
{% assign example_path="canL2" %}
{% assign example_service_name = page.example_device_name | append: "-can" %}

{% include content/io4edge/iou03-front/can-config-connect.md %}

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

Now you should see all frames that are sent on the CAN bus. Example:

```
Started stream
got stream data with 3 samples
  @56036918665 us: ID:7ff DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56037270984 us: ID:123 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56037462740 us: ID:456 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
got stream data with 3 samples
  @56038232385 us: ID:222 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56038422757 us: ID:334 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
  @56038632969 us: ID:555 DATA:22 33 44  ERROR:CAN_NO_ERROR STATE:CAN_OK
...
```



## SocketCAN Demo

In this demo, we'll demonstrate how to receive data from a CAN bus and print it to the console. This demo is using the Linux [SocketCAN framework](https://www.kernel.org/doc/html/latest/networking/can.html).

{% if is_mio %}

**WARNING** This documentation assumes that ModuCop is your target. Users of other Linux machines: Please install our Open Source [socketcan-io4edge](https://github.com/ci4rail/socketcan-io4edge) solution on your target.
{: .notice--warning}

{% endif %}

First, configure the bus parameters as described [here]({{ page.url | relative_url }}#busconfiguration).


#### Create a socketCAN instance

To access the {{ page.product_name }} via socketCAN, we create a virtual socketCAN network that matches the service name of your {{ page.product_name }} CAN Interface.

The virtual socket CAN network must be named according to {{ page.product_name }} CAN Interface service name. E.g. if the service name is `MYDEV-can`, the virtual socketCAN device must be named `vcanMYDEV` (without -can). Because network interface names can have only max. 15 characters, but service names can be longer, there is a rule to map longer service names to socketCAN device names:

`vcan<first-4-chars-of-instance-name>xx<last-5-chars-of-instance-name>`

 Examples:

* Service Name `S101-IOU04-USB-EXT-1-can` -> vcan name `vcanS101xxEXT-1`
* Service Name `123456789012-can` -> vcan name `vcan1234xx89012`
* Service Name `MIO04-1-can` -> vcan name `vcanMIO04-1`


Now, create a virtual socketCAN network. On your {{ target_name }}, execute:
```bash
ip link add dev {{ page.socketcan_name }} type vcan
ip link set up {{ page.socketcan_name }}
```

#### Function Test

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
