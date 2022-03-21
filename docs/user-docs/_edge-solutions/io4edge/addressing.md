---
title: io4edge Network Addressing
excerpt: Network Addring of io4edge devices
last_modified_at: 2022-03-21

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

To solve this issue, io4edge devices announce themselves (or better the services they provide) in the network. Each service (like an anlog input function block) is announced in the network with a specific name. For this, [MDNS](https://en.wikipedia.org/wiki/Multicast_DNS) is used, a protocol that is widely used, e.g. by office printers. To access a io4edge device from your application, you use the service address (a string) of the specific function rather an IP address.

### Addressing ModuCop I/O Modules

The base service addresses of ModuCop I/O Modules are assigned in the factory - before the assembled ModuCop is shipped - according to the following scheme:
`S101-<MODULE_TYPE>-USB-EXT-<SLOT_NUMBER>`, with
* `MODULE_TYPE` - I/O Module type, e.g. `IOU01`
* `SLOT_NUMBER` - Slot number, starting with `1` for the slot next to the CPU module.

So when you have an IOU01 module in slot, the service addresses would start with `S101-IOU01-USB-EXT-1`.

### Addressing WLAN and Ethernet Based io4edge Modules

By default, these devices use their *Article Number* and *Serial Number* as their base service address according to the following scheme:
`<ARTICLE_NUMBER>-<SERIAL_NUMBER>`, with
* `ARTICLE_NUMBER` - I/O Module group and type, e.g. `S103-MIO01`
* `SERIAL_NUMBER` - Serial number, an [UUIDV4](https://en.wikipedia.org/wiki/Universally_unique_identifier).

For example, a MIO01 would have a default base service name like this: `S101-MIO01-b4e31793-f660-4e2e-af20-c175186b95be`.

However, this address is only used as long no application specific `device-id` is set in the module. We recommend to change the `device-id` to an application defined name, such as `axle-sensor-left1`. This can be done using the `io4edge-cli` tool or via the console provided through the USB service connector. See the quick start guides of the respective module for details. As soon as a `device-id` is set, this name is now used as the base service name.

### Function Service Addresses
The service addresses for individual functions (like analog input and binary input) of an I/O module use the base service address plus a suffix, an IOU01 would have four services addresses, like:
* `S101-IOU01-USB-EXT-1` for the core block (firmware update etc.)
* `S101-IOU01-USB-EXT-1-binaryIoTypeA` for the binary I/O block
* `S101-IOU01-USB-EXT-1-analogInTypeA1` for the first analog input block
* `S101-IOU01-USB-EXT-1-analogInTypeA2` for the second analog input block

## Benefits of io4edge device addressing scheme

By using service addresses it is possible to hardcode these addresses in your application. It's possible because service addresses are configured in the device
* by you (the user) in case of WLAN/Ethernet devices
* in the factory in case of USB-based devices

## Restrictions

MDNS and therefore io4edge service addressing works only within a single IP subnet, i.e. devices and the client must be in the same subnet.

If the device and the host are in different subnets (a router is in between), then you must use IP addressing; to access a service, provide the IP address and the port.
