In this quick-start guide we will run demo programs that dump the frames on the MVB and CAN bus {{ page.product_name }} to the console.
{% include content/io4edge/quick-start/intro1.md %}

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

## MVB Demo

{% assign example_name="streamDump" %}
{% assign example_path="mvbSniffer" %}
{% assign example_service_ext="mvbSniffer" %}
{% assign example_service_name = page.example_device_name | append: example_service_ext %}

The MVB demo will dump the frames on the MVB bus to the console. The MVB bus is connected to the {{ page.product_name }} via the two bottom connectors.

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
