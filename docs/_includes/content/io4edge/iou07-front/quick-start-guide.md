In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary I/Os.
{% include content/io4edge/quick-start/intro1.md %}
* A laboratory Power Supply capable of supplying 5V..24V/200mA.

{% include content/io4edge/quick-start/intro2.md %}

{% if is_iou %}
| Service Name                         | Description         |
| ------------------------------------ | ------------------- |
| {{ page.example_device_name }}       | Core function       |
| {{ page.example_device_name }}-binio | Binary I/O function |

We need this service address in the demo programs to address the module, for example `{{ page.example_device_name }}-binio`.

{% include content/io4edge/quick-start/intro3.md %}
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
S101-IOU01-USB-EXT-1, 192.168.201.1, S101-IOU01, <serial-number>
+-----------------------------+-----------------------------+-------+
|        SERVICE TYPE         |            SERVICE NAME     | PORT  |
+-----------------------------+-----------------------------+-------+
| _io4edge_binaryIoTypeC._tcp | {{ page.example_device_name }}-binio  | 10000 |
+-----------------------------+-----------------------------+-------+
```
{% endif %}

## Binary I/O Demo

{% assign example_name="blinky" %}
{% assign example_path="binaryIoTypeC" %}
{% assign example_service_ext="binio" %}
{% assign example_service_name = page.example_device_name | append: "-binio" %}

The Binary I/O demo will stimulate the binary outputs 1..4 of the {{ page.product_name }} one after another. Please supply the first binary I/O group with 24V, so when the output drives a high level, the binary I/O pin has 24V, which in turn illuminates the corresponding LED.

You will see a running light on the 4 LEDs.

### Connecting

Plug a mating connector to the two top connectors of the {{ page.product_name }}.

{% include content/io4edge/iou07-front/mating-connectors.md %}

Connect the `+` and `-` pins of the first I/O group to your laboratory power supply which is set to a voltage of 18..36V.

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou07/iou07-qs.svg' | relative_url }})

### Demo Software
{% include content/io4edge/io4edge-go-example.md %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```

You should see now the first 4 LEDs of the {{page.product_name}} running.
