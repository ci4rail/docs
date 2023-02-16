---
title: IOU06 Quick-Start-Guide / IBIS Demo
excerpt: IOU06 extension module IBIS Quick Start
last_modified_at: 2022-08-10

custom_next: /edge-solutions/moducop/io-modules/iou06/quick-start-can-io4edge/
product_name: IOU06
article_group: S101
example_device_name: S101-IOU06-USB-EXT-1

---

## IBIS Quick Start

The {{ page.product_name }}'s IBIS master appears as a serial port to the ModuCop. This section only explains how to find the tty device for IBIS. A simple demo isn't possible, because it's a IBIS master only. Therefore, you must attach it to one or more slave devices or a slave simulator, and you need a piece of code that implements the IBIS protocol (for example [pyFIS](https://github.com/Mezgrman/pyFIS)).

Preparation Steps:
* Connect a PC and ModuCopto the same network, e.g. by using an Ethernet Switch or a Wifi Access Point
* From the PC, login into the ModuCop via ssh

### Check whether {{ page.product_name }} IBIS port is recognized on ModuCop

ModuCop's linux image is configured to detected COM Ports of io4edge devices automatically.

For each detected COM port, a linux device `/dev/tty<device-ID>-<port>` is created. For example, if your device ID is `{{ page.example_device_name }}`, you'll find the following tty device for IBIS:

```bash
root@moducop-cpu01: ~# ls -l /dev/tty{{ page.example_device_name }}*
crw-rw---- 1 root dialout 199, 3 Jul 28 13:33 /dev/tty{{ page.example_device_name }}-ibis
```
