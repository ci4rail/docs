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

{% include content/tab-select.md head=true instance=tab_instance %}

Run this in a powershell console
```powershell
cd examples\{{ example_path }}\{{ example_name }}
$Env:GOOS = "linux"
$Env:GOARCH = "{{ target_arch }}"
go build
```

{% include content/tab-select.md middle=true instance=tab_instance %}

```bash
cd examples/{{ example_path }}/{{ example_name }}
GOOS=linux GOARCH={{ target_arch }} go build
```

{% include content/tab-select.md foot=true %}

This produces the binary file `{{ example_name }}` in the current folder.

#### Copy Demo to {{ target_name }}

Transfer the compiled binary. Replace `<target-ip>` with the IP address of your {{ target_name }}.

{% if is_iou %}
We copy the binary to the `/data` folder of ModuCop, as this is a writeable, whereas the rest of the filesystem is write protected.
{% endif %}


{% if is_iou %}
```console
scp {{ example_name }} root@<target-ip>:/data
```
{% else %}
```console
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
