---
title: SIO03-99 Quick Start Guide
excerpt: First steps to work with SIO03-99

product_name: SIO03-99
article_group: S103
example_device_name: sio03-1
custom_next: /lyve/lyve-tracelets/sio03-99/detailed-description/
---

This guide shows how to setup initially the {{ page.product_name }}, i.e. supply it with power and connect it
to a PC using a serial over USB console to perform initial configuration.

## Establishing Host Connection and Power

The power may be provided via
* Power-Over-Ethernet
* Power Input

In any case, establish a USB connection to the device, so that we can enter the initial device parameters. From the power connector, connect the following pins to an USB-A connector:

```
7 - V_USB - USB Power Supply Input
4 - USB-
8 - USB+
5 - GND
```

### Supply via Power over Ethernet
{{ page.product_name }} is a Class 1 PoE powered device. Connect the to a PoE source that can supply class 1 devices.

![PoE connection]({{ '/user-docs/images/lyve/sio03-99-poe.svg' | relative_url }}){: style="width: 100%"}


### Supply via Power Input

Use a power supply capable of delivering 12V..24VDC, 5W. Use contacts 1 and 6 to supply the power. Connect IGN to V_IN (1) to enable the device.

![Powerin connection]({{ '/user-docs/images/lyve/sio03-99-powerin.svg' | relative_url }}){: style="width: 100%"}


## Initial Configuration

For initial configuration, connect the USB-Serial Console interface to a computer as shown above and start a terminal program. See [Instructions]({{ '/edge-solutions/modusio/config-console' | relative_url }}) for details.

Press Enter in the Terminal program, and you should see the config prompt:

```
config>
```

### Configure Device ID
To identify the device in the network, configure a device ID. This ID is used as the network hostname and is used as the `tracelet_id` in the position messages.

Each device in the network shall have a unique name. The name shall consist only of alphanumeric characters, `-` and `_`. Avoid blanks and special characters.

```
config> device-id {{ page.example_device_name }}
Setting device-id to {{ page.example_device_name }}
A 'reboot' is required to activate the new setting!
```


### Configure IP Address

The Device needs an IP address in the network. It can be configured to use a static IP address or to use dynamic IP address, provided by a DHCP server.

#### Setup for DHCP
To obtain the devices IP address from a DHCP server, clear any static IP address setting:

```
config> static-ip ""
Delete static-ip
```

You can ignore the message: `Can't set static-ip: ESP_ERR_NVS_NOT_FOUND`. This is normal if no static IP has not been configured before.
{: .notice--info}

Activate the changes:
```
config> reboot
```

#### Setup Static IP
To use a static IP address, configure the IP-Address, Gateway and Network Mask using the `static-ip` command. The three parameters have to be specified as a single string, separated by colons (`:`), `<ip>:<netmask>:<gateway>`.

```
config> static-ip 192.168.1.56:255.255.255.0:192.168.1.1
Setting static-ip to '192.168.1.56:255.255.255.0:192.168.1.1'
A 'reboot' is required to activate the new setting!
```
Activate the changes:
```
config> reboot
```

#### Connection Test

Now try to test the connection using `ping` from a computer in the same network as your device. Use the device ID of your device and append `.local`.
```
$ ping {{ page.example_device_name }}.local
PING {{ page.example_device_name }}.local (192.168.1.56) 56(84) bytes of data.
64 bytes from 192.168.1.56: icmp_seq=1 ttl=255 time=57.1 ms
64 bytes from 192.168.1.56: icmp_seq=2 ttl=255 time=76.4 ms
```

## Basic GNSS Test

We now check that GNSS is basically working.

Place the {{ page.product_name }} into a place with good sky view.

After powering on the device, look into the USB console and look for lines like these:

```
I (18614) ubx_config: PVAT LAT: 49.430953, LONG: 11.071027, HEIGHT: 370.866000, H_ACC: 2.823000, V_ACC: 3.488000, NUM_SV: 11 FIX: 3 DTVALID 1/f7
```

After one minute, the fix type `FIX: ` should be at least `3` (which indicates a DGPS fix). As we haven't yet configured a RTK correction service, this is the maximum fix type we can achieve.
