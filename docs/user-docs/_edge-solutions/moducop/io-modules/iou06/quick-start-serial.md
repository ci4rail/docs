---
title: IOU06 Quick-Start-Guide / Serial Demo
excerpt: IOU06 extension module COM port demo

custom_next: /edge-solutions/moducop/io-modules/iou06/quick-start-audio
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

# Serial Port Demo

In this demo, we'll demonstrate how to connect an application on ModuCop with a {{ page.product_name }} COM port. We'll use a cable to loop the RS422/485 transmit pins to the receive pins, so that we'll get all characters back that are sent to the COM port.

Preparation Steps:
* Connect a PC and ModuCopto the same network, e.g. by using an Ethernet Switch or a Wifi Access Point
* From the PC, login into the ModuCop via ssh

### Check whether {{ page.product_name }} COM ports are recognized on ModuCop

ModuCop's linux image is configured to detected COM Ports of io4edge devices automatically.

For each detected COM port, a linux device `/dev/tty<device-ID>-com` is created. For example, if your {{ page.product_name }} device ID is `{{ page.example_device_name }}`, you'll find the following tty device:

```bash
root@moducop-cpu01: ~# ls -l /dev/tty{{ page.example_device_name }}*
crw-rw---- 1 root dialout 199, 3 Jul 28 13:33 /dev/tty{{ page.example_device_name }}-com
```

If you don't see this device, but you see a `-can` device, you have to clear the CAN configuration, in order to activate the COM port.

On your ModuCop, run:
```bash
io4edge-cli -d {{ page.example_device_name }} set-parameter can-config ""
# Restart to apply parameters
io4edge-cli -d {{ page.example_device_name }} restart
```


### Function Test
Now, let's make a hardware loop between the RS422/485 transmit pins to the receive pins of the COM1 RS232 interface. Connect pin 1 to 4 and 6 to 9 of the CAN/COM port D-Sub connector:

### Review 0
![COM Loop]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/qs-com-layout0-loop.svg' | relative_url }}){: style="width: 20%"}

### Review 1
![COM Loop]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/qs-com-layout1-loop.svg' | relative_url }}){: style="width: 20%"}

Start the `minicom` terminal program on ModuCop:
```bash
root@moducop-cpu01: ~# minicom -D /dev/tty{{ page.example_device_name }}-com1 -b 115200
```
Because we don't have hardware flow control lines, we have to tell minicom not to use hardware flow control:
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
Press two times `ESC` and you are back in the main screen of minicom.

Now type some character, and you should see that the characters are echoed back, due to the hardware loop we have created!

```
Welcome to minicom 2.7.1

OPTIONS: I18n
Compiled on Apr 18 2017, 09:55:23.
Port /dev/tty{{ page.example_device_name }}-com, 13:45:27

Press CTRL-A Z for help on special keys

dddddddddddd..ffffdddddddddddddddd
```

To leave minicom, type `CTRL-A`, followed by `x`.
