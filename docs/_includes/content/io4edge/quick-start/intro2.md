### Tools on Development PC
The examples are written in programming language [Go](https://go.dev/), we download the go sources and compile them. Therefore we need some tools on your development PC:

* [git]({{ '/edge-solutions/tools/git' | relative_url }})
* [go](https://go.dev/doc/install)

### Get Demo Software {#getdemosoftware}

Clone the repository containing the examples to a folder of your choise (here `myworkdir`)

{% include content/tabv2/start.md tabs="Windows, Linux" instance="pre" %}
<!--- Linux Start --->

```powershell
c:
cd \myworkdir
git clone https://github.com/ci4rail/io4edge-client-go.git
cd io4edge-client-go
```

<!--- Linux End --->
{% include content/tabv2/next.md %}
<!--- Windows Start --->

```bash
cd ~/myworkdir
git clone https://github.com/ci4rail/io4edge-client-go.git
cd io4edge-client-go
```

<!--- Windows End --->
{% include content/tabv2/end.md %}


{% if is_iou %}

### Determine the Service Address of your {{ page.product_name }}
Io4Edge Devices are usually addressed by their service address, which is a name in the network.

The {{ page.product_name }}'s service name depends on the ModuCop's slot and is usually
`{{ full_product_name }}-USB-EXT-<slot-number>[-<function>]`, i.e. if the {{ page.product_name }} is in the slot next to ModuCops CPU01, we have the following service names:
{% endif %}

{% if is_mio %}

{% endif %}
