## Establishing Host Connection and Power

ModuSio devices can be connected to the Network via Ethernet or Wifi. Please select the tab for your preferred option:

{% include content/tab/start.md tabs="Ethernet, Wifi" instance="qs1" %}
{% include content/tab/entry-start.md %}

### Network and Power Connection
ModuSio devices are Class 2 (3,84–6,49 W) PoE powered devices. Connect the ModuSio Device to a PoE source that can supply class 2 devices. ModuSios expect the PoE power as phantom power, i.e. using the Ethernet Tx and Rx pins.

![PoE connection]({{ '/user-docs/images/edge-solutions/modusio/modusio-poe.svg' | relative_url }}){: style="width: 100%"}

### Initial Device Configuration

For initial configuration, connect the `SERVICE` interface to a computer and start a terminal program. See [Instructions]({{ '/edge-solutions/modusio/config-console' | relative_url }}) for details.

Press Enter in the Terminal program, and you should see the config prompt:

```
config>
```

Configure the device for Ethernet operation. The device is configured for Ethernet when it is *NOT* configured for Wifi. So we clear Wifi settings:
```
config> wifi-ssid ""
Delete wifi-ssid
```

You can ignore the message: `Can't set wifi-ssid: ESP_ERR_NVS_NOT_FOUND`. This is normal if wifi has not been configured before.
{: .notice--info}

#### Setup for DHCP
To obtain the devices IP address from a DHCP server, clear any static IP address setting:

```
config> static-ip ""
Delete static-ip
```

You can ignore the message: `Can't set static-ip: ESP_ERR_NVS_NOT_FOUND`. This is normal if no static IP has not been configured before.
{: .notice--info}

Activate the changes:
```
config> reboot
```


#### Setup Static IP
To use a static IP address, configure the IP-Address, Gateway and Network Mask using the `static-ip` command:

The three parameters have to be specified as a single string, separated by colons (`:`), `<ip>:<gateway>:<netmask`>`.

```
config> static-ip 192.168.24.88:192.168.24.1:255.255.255.0
Setting static-ip to '192.168.24.88:192.168.24.1:255.255.255.0'
A 'reboot' is required to activate the new setting!
```



{% include content/tab/entry-end.md %}
{% include content/tab/entry-start.md %}

When using Wifi, supply the ModuSio by an power supply, capable of delivering 12V..24VDC, 5W. Use contacts 5+6 and 7+8 to supply the power. Polarity doesn't matter.

For initial configuration, connect the `SERVICE` interface to a computer using a USB cable.

![Wifi connection]({{ '/user-docs/images/edge-solutions/modusio/modusio-wifi.svg' | relative_url }}){: style="width: 100%"}


{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}

#### Activate Changes

```
config> reboot
```





### Using Power-Over-Ethernet {#poe}


TODO: Image PoE Switch and Moducop with PoE

### Using Auxiliary Power {#auxpower}





{% include content/io4edge/quick-start/intro1.md %}
* A laboratory Power Supply capable of supplying 5V..24V/200mA.

{% include content/io4edge/quick-start/intro2.md %}
| Service Name                              | Description            |
| ----------------------------------------- | ---------------------- |
| {{ mdns_service_address }}                | Core function          |
| {{ mdns_service_address }}-binaryIoTypeA  | Binary I/O function    |
| {{ mdns_service_address }}-analogInTypeA1 | Analog Input channel 1 |
| {{ mdns_service_address }}-analogInTypeA2 | Analog Input channel 2 |

{% include content/io4edge/quick-start/intro3.md %}


## Binary I/O Demo

{% assign example_name="blinky" %}
{% assign example_path="binaryIoTypeA" %}
{% assign example_service_name = full_product_name | append: "-USB-EXT-1-binaryIoTypeA" %}

The Binary I/O demo will stimulate the binary outputs of the {{ page.product_name }} one after another. Please supply the binary I/O groups with 24V, so when the output switch turns on, the binary I/O pin has 24V, which in turn illuminates the corresponding LED.

You will see a running light on the 4 LEDs.

### Connecting

Plug a mating connector to the two top connectors of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `CI` and `CO` pins to your laboratory power supply which is set to a voltage of 24V (up to 110V).
**Warning** Caution, voltages over 60V are dangerou! If voltages above 60 V DC are used, ensure that all necessary protective measures are taken and that only qualified personnel is using the equipment.
{: .notice--warning}


![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-binio.svg' | relative_url }})

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

You should see now the 4 LEDs of the binary I/O running.

## Analog Input Demo
{% assign example_name="stream" %}
{% assign example_path="analogInTypeA" %}
{% assign example_service_ext="analogInTypeA1" %}

The Analog Input demo will sample one analog input of the {{ page.product_name }} for 10 seconds, with the sample rate you specify on the command line. The sampled values are printed.

### Connecting

Plug a mating connector to the 3rd connector from the top of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `0V` and `Uin1` pins to your laboratory power supply which is set to a voltage of 5V.

![Connection for Analog Input Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-anain.svg' | relative_url }})

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
/data/{{example_name}} {{ full_product_name }}-USB-EXT-1-{{ example_service_ext }} 400 | more
```
You should see now the sampled values together with the timestamp:
```
Started stream
got stream data seq=1 ts=22224066708
  #0: ts=22223821033 0.5076
  #1: ts=22223823468 0.5077
  #2: ts=22223825968 0.5076
  #3: ts=22223828468 0.5077
  #4: ts=22223830994 0.5077
  #5: ts=22223833468 0.5076
  #6: ts=22223835968 0.5077
  #7: ts=22223838468 0.5077
  #8: ts=22223841003 0.5077
  #9: ts=22223843468 0.5077
  #10: ts=22223845968 0.5076
  #11: ts=22223848468 0.5076
  #12: ts=22223850999 0.5076
  #13: ts=22223853468 0.5076
  #14: ts=22223855968 0.5077
  #15: ts=22223858468 0.5076
  ...
```

The sampled values are normalized, so the value `1.0` represents full-scale, i.e. 10 Volts.

The timestamps are expressed in microseconds since the start of the {{ page.product_name }}.
