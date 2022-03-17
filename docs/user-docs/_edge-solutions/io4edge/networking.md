---
title: io4edge Networking
excerpt: Network behaviour of io4edge devices
last_modified_at: 2022-03-17

custom_next: /edge-solutions/io4edge/management
---

io4edge devices are always connected to the host via network, either via
* Ethernet over USB (ModuCop I/O Modules and Microcontrollers on CPU boards)
* Ethernet (ModuSio)
* WLAN (ModuSio)

## IP Address Assignment

All io4edge devices receive their IP address via [DHCP](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol), so you need a DHCP server in your network to which the io4edge device is connected to. A fixed IP address assignment is not planned.

**Notice** On Moducop, a DHCP is already installed and setup in the Yocto image. However, this DHCP server is only responsible to assign a IP address for io4edge devices within the ModuCop. If further devices are connected via Ethernet/Wifi, still a DHCP server must be in the network.
{: .notice}

## How to Address a Specific Device from the Host

Consider the following scenario: You have five identical io4edge devices (e.g. ModuSios) connected to your network. Each one got an IP address from the DHCP server. But how do you know which device has which IP address? Even if you find it out by checking your router's device table, the information is valid only for this particular network. If you want to duplicate the setup later for production, devices may get different IP addresses. This is bad.

To solve this issue, io4edge devices announce themselves (or better the services they provide) in the network. Each service (like an anlog input function block) is announced in the network with a specific name. For this, [MDNS](https://en.wikipedia.org/wiki/Multicast_DNS) is used, a protocol that is widely used, e.g. by office printers.

Each service has an `instance name` and a `protocol`
