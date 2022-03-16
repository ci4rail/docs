{% assign full_product_name = page.article_group | append: "-" | append: page.product_name %}
{% if page.article_group == "S103" %}
  {% assign example_exec_dir ="." %}
{% else %}
  {% assign example_exec_dir ="/data" %}
{% endif %}

In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary I/Os and to read values from the analog inputs.

## Prerequisites

### Hardware
* A Moducop Edge Computer with a {{ page.product_name }} installed
* A development PC (Windows or Linux), connected via Network to the Moducop
* A Laboratory Power Supply capable of supplying 5V..24V/200mA.

{% include content/io4edge/go-examples-prerequisites.md %}



| Service Name                                     | Description            |
| ------------------------------------------------ | ---------------------- |
| {{ full_product_name }}-USB-EXT-1                | Core function          |
| {{ full_product_name }}-USB-EXT-1-binaryIoTypeA  | Binary I/O function    |
| {{ full_product_name }}-USB-EXT-1-analogInTypeA1 | Analog Input channel 1 |
| {{ full_product_name }}-USB-EXT-1-analogInTypeA2 | Analog Input channel 2 |

We need this service address in the demo programs to address the module, for example to address the binary I/O function, we would use `{{ full_product_name }}-USB-EXT-1-binaryIoTypeA `.

If you are unsure, you can also browse the available devices:


```bash
ssh root@<moducop-ip>
```

Once logged in into the Moducop Shell:
```bash
avahi-browse -at | grep io4edge
```
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
+ usb_ext_1 IPv4 {{ full_product_name }}-USB-EXT-1                          _io4edge-core._tcp   local
+ usb_ext_1 IPv4 {{ full_product_name }}-USB-EXT-1-binaryIoTypeA            _io4edge_binaryIoTypeA._tcp local
+ usb_ext_1 IPv4 {{ full_product_name }}-USB-EXT-1-analogInTypeA2           _io4edge_analogInTypeA._tcp local
+ usb_ext_1 IPv4 {{ full_product_name }}-USB-EXT-1-analogInTypeA1           _io4edge_analogInTypeA._tcp local
```


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

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-binio.svg' | relative_url }})

### Demo Software
{% include content/io4edge/iou-go-example.md %}

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

Plug a mating connector to the 3rd connectors from the top of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `0V` and `Uin1` pins to your laboratory power supply which is set to a voltage of 5V.

![Connection for Analog Input Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-anain.svg' | relative_url }})

### Demo Software
{% include content/io4edge/iou-go-example.md %}

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
