#### Compile Demo
{% assign tab_instance = example_name  | append: "1" %}

{% include content/tab-select.md head=true instance=tab_instance %}

```console
cd examples\{{ example_path }}\{{ example_name }}
GOOS=linux GOARCH=arm64 go build
```

{% include content/tab-select.md middle=true instance=tab_instance %}

```bash
cd examples/{{ example_path }}/{{ example_name }}
GOOS=linux GOARCH=arm64 go build
```

{% include content/tab-select.md foot=true %}

This produces the binary file `{{ example_name }}` in the current folder.

#### Copy Demo to ModuCop

Transfer the compiled binary. Replace `<moducop-ip>` with the IP address of your ModuCop.
We copy the binary to the `/data` folder of ModuCop, as this is a writeable, whereas the rest of the filesystem is write protected.

{% assign tab_instance = example_name | append: "2" %}

{% include content/tab-select.md head=true instance=tab_instance %}


```console
scp {{ example_name }} root@<moducop-ip>:/data
```

{% include content/tab-select.md middle=true instance=tab_instance %}

```bash
scp {{ example_name }} root@<moducop-ip>:/data
```

{% include content/tab-select.md foot=true %}

#### Running the Demo

Login into your Moducop over SSH:

```bash
ssh root@<moducop-ip>
```

Once logged in into the Moducop Shell, run the demo.
In case your {{ page.product_name }} is not in the slot next to the CPU, use a different address, e.g. `{{ full_product_name }}-USB-EXT-2-{{ example_service_ext }}`
