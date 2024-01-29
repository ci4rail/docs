---
title: io4edge Devices
excerpt: Introducion to io4edge Devices
last_modified_at: 2022-11-01

custom_next: /edge-solutions/io4edge/addressing
---

## What is io4edge?
io4edge is the family name for I/O modules that are connected to the host via network (Ethernet, WLAN, Ethernet over USB). All io4edge Devices share some common functionality such as.

* [Network Addressing]({{ '/edge-solutions/io4edge/addressing' | relative_url }}) via zeroconf (MDNS) addresses
* Communication with the host through TCP sockets and [Google Protobuf](https://developers.google.com/protocol-buffers) messages
* [Device Management]({{ '/edge-solutions/io4edge/management' | relative_url }}) over Network for
  * Firmware Update
  * Firmware Identification
  * Inventory Data
  * Device Reboot

### Open Source Client Libraries

io4edge device are supported by open source host libraries for the following programming languages:
* Go: [io4edge-client-go](https://github.com/ci4rail/io4edge-client-go)
* Python: [io4edge-client-python](https://github.com/ci4rail/io4edge-client-python)
* C : [io4edge-client-c](https://github.com/ci4rail/io4edge-client-c)

## io4edge Devices

* [Moducop I/Os]({{ '/edge-solutions/moducop/io-modules' | relative_url }})
* [ModuSio]({{ '/edge-solutions/modusio' | relative_url }})
* Onboard Microcontrollers, such as the I/O controller on our ModuCop CPU01
