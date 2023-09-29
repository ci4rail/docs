---
title: IOU06 Quick-Start-Guide / IBIS Demo
excerpt: IOU06 extension module IBIS Quick Start
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou06/detailed-description/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary I/Os and to read values from the analog inputs.
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

We need this service address in the demo programs to address the module, for example to address the binary I/O function, we would use `{{ page.example_device_name }}-binaryIoTypeB`.

{% include content/io4edge/quick-start/intro3.md %}
If your {{ page.product_name }} is in the slot next to the CPU, the output should be:
```
S101-IOU01-USB-EXT-1, 192.168.201.1, S101-IOU01, <serial-number>
+-----------------------------+-------------------------------------+-------+
|        SERVICE TYPE         |            SERVICE NAME             | PORT  |
+-----------------------------+-------------------------------------+-------+
| _ttynvt._tcp                | S101-IOU06-USB-EXT-3-ibis           | 10000 |
| _ttynvt._tcp                | S101-IOU06-USB-EXT-3-com            | 10001 |
| _io4edge_binaryIoTypeB._tcp | S101-IOU06-USB-EXT-3-gpio           | 10002 |
+-----------------------------+-------------------------------------+-------+
```
{% endif %}

## Binary I/O Demo

{% assign example_name="blinky" %}
{% assign example_path="gpio" %}
{% assign example_service_ext="gpio" %}
{% assign example_service_name = page.example_device_name | append: "-gpio" %}

The Binary I/O demo will stimulate the binary outputs of the {{ page.product_name }} one after another. Please supply the binary I/O groups with 24V, so when the output switch turns on, the binary I/O pin has 24V.


### Connecting

Plug a mating connector to the two top connectors of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `CI` and `CO` pins to your laboratory power supply which is set to a voltage of 24V (up to 36V).



![Connection for Binary Output Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/binout-conn.svg' | relative_url }})

### Demo Software
#### Compile Demo
{% if is_mio %}
  {% assign target_arch ="arm" %}
  The demo must be compiled for the architecture of your target machine. Typical targets are:
  - modern x86 PCs: Architecture = `amd64`
  - RaspberryPi (32 Bit): `arm`
  - ModuCop: `arm64`

In the following examples, we use `{{ target_arch }}`.
{% else %}
  {% assign target_arch ="arm64" %}
{% endif %}


{% assign tab_instance = example_name  | append: "1" %}
{% include content/tab/start.md tabs="Windows, Linux" instance=tab_instance %}
{% include content/tab/entry-start.md %}

Run this in a powershell console
```powershell
cd examples\{{ example_path }}\{{ example_name }}
$Env:GOOS = "linux"
$Env:GOARCH = "{{ target_arch }}"
go build
```
{% include content/tab/entry-end.md %}

{% include content/tab/entry-start.md %}

```bash
cd examples/{{ example_path }}/{{ example_name }}
GOOS=linux GOARCH={{ target_arch }} go build
```
{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}

This produces the binary file `{{ example_name }}` in the current folder.

#### Copy Demo to {{ target_name }}

Transfer the compiled binary. Replace `<target-ip>` with the IP address of your {{ target_name }}.

{% if is_iou %}
We copy the binary to the `/data` folder of ModuCop, as this is a writeable, whereas the rest of the filesystem is write protected.
{% endif %}


{% if is_iou %}
```bash
scp {{ example_name }} root@<target-ip>:/data
```
{% else %}
```bash
scp {{ example_name }} <target-ip>:/~
```
{% endif %}


#### Running the Demo

Login into your {{ target_name }} over SSH:

{% if is_iou %}
```bash
ssh root@<target-ip>
```
{% else %}
```bash
ssh <target-ip>
```
{% endif %}

Once logged in into the {{ target_name }}'s Shell, run the demo.

{% if is_iou %}
In case your {{ page.product_name }} is not in the slot next to the CPU, use a different address, e.g. `{{ full_product_name }}-USB-EXT-2-{{ example_service_ext }}`
{% endif %}

```bash
{{ example_exec_dir }}/{{example_name}} {{ example_service_name }}
```
