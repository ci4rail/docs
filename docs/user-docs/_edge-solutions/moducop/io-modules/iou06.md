---
title: IOU06 - Communication Interfaces
excerpt: IOU06 - Communication extension unit for trams & busses

custom_next: /edge-solutions/moducop/io-modules/iou06/quick-start-guide
product_name: IOU06

type: io-module
---

Welcome to the {{ page.product_name }} documentation.

![{{ page.product_name }} product view]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/product-in-moducop.png' | relative_url }}){: style="width: 50%"}


{{ page.product_name }} is a communication extension unit for trams & busses. It upgrades ModuCop Edge Computer to a full-featured OBU (onboard unit) by adding often desired interfaces in bus and tram applications.

# Features

* 1 slot (7 HP) extension unit for ModuCop Edge Computer
* 1 IBIS Master
  * Appears as a standard tty device on Linux hosts
* 1 ISO 11898 CANBus Interface, up to 1MBit/s
  * Usable for direct I/O or as data logger with multiple data streams.
  * SocketCAN Support
* 1x RS422/485, shared DSub with CAN
  * Appears as a standard tty device on Linux hosts
* 1x Audio Interface (2x Line Out (mono); 1x Line In (mono))
  * Linux ALSA compatible
* 2 Binary Outputs 24V
* Galvanic isolation of all interfaces
* EN 50155 compliant, UN-ECE R10 (E-Mark) (integrated in ModuCop)

{{ page.product_name }} is an Io4Edge device, and therefore supports the features common to all [Io4Edge devices]({{ '/edge-solutions/io4edge' | relative_url }}).
