---
title: Console
excerpt: How to use the USB serial console of the ModuCop
order: 40
category: yocto-bsp-manual
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The ModuCop Edge Computer MEC01/02 provides a USB serial console for debugging and development purposes.

It is helpful also for initial setup, such as configuring the network interfaces or setting up the device for the first time. It also allows you to enter the u-boot bootloader console.

The USB serial console is available behind the service cover, it is the left USB-C port:

![Service Interfaces]({{ '/user-docs/images/moducop/user-manual/service-interfaces-photo.svg' | relative_url }})

The serial parameters are:
- **Baud rate**: 115200
- **Data bits**: 8
- **Parity**: None
- **Stop bits**: 1
- **Flow control**: None

The BSP launches a getty on the USB serial console, so you can log in with the root user and the password `cheesebread`.
