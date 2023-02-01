---
title: MIO04 - CAN & Serial Interfaces
excerpt: MIO04 - IP based remote serial & CAN interface unit for edge applications in rail system.
last_modified_at: 2022-10-28

custom_next: /edge-solutions/modusio/mio04/quick-start-guide
product_name: MIO04

type: modusio-module
---

Welcome to the {{ page.product_name }} documentation

![{{ page.product_name }} product view]({{ '/user-docs/images/edge-solutions/modusio/mio04/product_frontal.png' | relative_url }}){: style="width: 15%"}


{{ page.product_name }} is a serial and CAN interface module with Ethernet and WLAN connectivity for edge applications in rail systems.

# Features

* Ethernet and WLAN communication interface to host
* Power Supply via PoE or 12V/24V (DC)
* 2 serial interfaces with RS232 or RS485-full-duplex or RS485-half-duplex
  * Virtual tty support using [RFC2217](https://datatracker.ietf.org/doc/html/rfc2217)
  * Appears as a standard tty device on Linux hosts
* 1 ISO 11898 CANBus Interface, up to 1MBit/s
  * Usable for direct I/O or as data logger with multiple data streams.
  * SocketCAN Support
* Galvanic isolation of all inputs and outputs
* EN 50155 compliant

{{ page.product_name }} is an Io4Edge device, and therefore supports the features common to all [Io4Edge devices]({{ '/edge-solutions/io4edge' | relative_url }}).

## Detailed Technical Specification

Please refer to the [Data Sheet](https://www.ci4rail.com/wp-content/uploads/2022/04/MIO04_DS_en.pdf)
