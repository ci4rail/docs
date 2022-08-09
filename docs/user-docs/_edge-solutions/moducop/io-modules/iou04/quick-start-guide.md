---
title: IOU04 Quick-Start-Guide
excerpt: Quick startup with IOU04 extension module
last_modified_at: 2022-08-09

custom_next: /edge-solutions/moducop/io-modules/iou04/detailed-description/
product_name: IOU04
article_group: S101
example_device_name: S101-IOU04-USB-EXT-1

---

## Serial Port Demo

In this demo, we'll demonstrate how to connect an application on ModuCop with a {{ page.product_name }} COM port. We'll use a cable to loop the RS232 transmit pin to the receive pin, so that we'll get all characters back that are sent to the COM port.

Preparation Steps:
* Connect a PC and ModuCopto the same network, e.g. by using an Ethernet Switch or a Wifi Access Point
* From the PC, login into the ModuCop via ssh

#### Check whether {{ page.product_name }} COM ports are recognized on ModuCop

ModuCop's linux image is configured to detected COM Ports of io4edge devices automatically.

For each detected COM port, a linux device `/dev/tty<device-ID>-com<port>` is created. For example, if your {{ page.product_name }} device ID is `{{ page.example_device_name }}`, you'll find the following tty devices:

```bash
root@moducop-cpu01: ~# ls -l /dev/tty{{ page.example_device_name }}*
crw-rw---- 1 root dialout 199, 3 Jul 28 13:33 /dev/tty{{ page.example_device_name }}-com1
crw-rw---- 1 root dialout 199, 4 Jul 28 13:33 /dev/tty{{ page.example_device_name }}-com2
```

#### Function Test
Now, let's make a hardware loop between the RS232 transmit and receive pin of the COM1 RS232 interface. Connect pin 2 and 3 of the COM ports D-Sub connector:

![COM Loop]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou04/iou04-qs-com-loop.svg' | relative_url }}){: style="width: 10%"}

Start the `minicom` terminal program on ModuCop:
```bash
root@moducop-cpu01: ~# minicom -D /dev/tty{{ page.example_device_name }}-com1 -b 115200
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

Now type some character, and you should see that the characters are echoed back, due to the hardware loop we have created!

```
Welcome to minicom 2.7.1

OPTIONS: I18n
Compiled on Apr 18 2017, 09:55:23.
Port /dev/tty{{ page.example_device_name }}-com1, 13:45:27

Press CTRL-A Z for help on special keys

dddddddddddd..ffffdddddddddddddddd
```

To leave minicom, type `CTRL-A`, followed by `x`.
