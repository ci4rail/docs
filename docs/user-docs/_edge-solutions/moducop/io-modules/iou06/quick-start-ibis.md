---
title: IOU06 Quick-Start-Guide / IBIS Demo
excerpt: Quick startup with IOU06 extension module
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou06/detailed-description/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

# IBIS Demo

In this demo, we'll demonstrate how to use the ModuCop {{ page.product_name }} IBIS master. A simple demo isn't possible, because the IBIS master is a master only. Therefore, you must attach it to one or more slave devices or a slave simulator.

Preparation Steps:
* Connect a PC and ModuCopto the same network, e.g. by using an Ethernet Switch or a Wifi Access Point
* From the PC, login into the ModuCop via ssh

### Check whether {{ page.product_name }} COM ports are recognized on ModuCop

ModuCop's linux image is configured to detected COM Ports of io4edge devices automatically.

For each detected COM port, a linux device `/dev/tty<device-ID>-com<port>` is created. For example, if your {{ page.product_name }} device ID is `{{ page.example_device_name }}`, you'll find the following tty device:

```bash
root@moducop-cpu01: ~# ls -l /dev/tty{{ page.example_device_name }}*
crw-rw---- 1 root dialout 199, 3 Jul 28 13:33 /dev/tty{{ page.example_device_name }}-ibis
```

TODO: Replace by IBIS master demo
### Function Test
Now attach the {{ page.product_name }} IBIS port to the supply voltage and to a bus with one or more IBIS slaves.

```bash

![IBIS Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/iou06-qs-com-loop.svg' | relative_url }}){: style="width: 10%"}

Start the `minicom` terminal program on ModuCop:
```bash
root@moducop-cpu01: ~# minicom -D /dev/tty{{ page.example_device_name }}-com1 -b 1200
```
Because we haven't connected hardware flow control lines, we have to tell minicom not to use hardware flow control:
* Press `CTRL-A` followed by `O` (O like Omega)
```

            ┌─────[configuration]──────┐
            │ Filenames and paths      │
            │ File transfer protocols  │
            │ Serial port setup        │
            │ Modem and dialing        │
            │ Screen and keyboard      │
            │ Save setup as dfl        │
            │ Save setup as..          │
            │ Exit                     │
            └──────────────────────────┘
```
* Select `Serial Port Setup`
* Press `F`

Then hardware flow control should be off:
```
F - Hardware Flow Control : No
```
Press two times `ESC` and you are back in the main screeen of minicom.

Now you can enter characters that are sent to the IBIS bus.

To leave minicom, type `CTRL-A`, followed by `x`.
