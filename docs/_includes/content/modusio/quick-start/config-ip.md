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

##### Find out IP Address of your Device
This step depends on your DHCP server.

For example, if you have an Internet router that runs the DHCP server, login into the web interface of your Internet router.

In the management interface of your DHCP server, look for a device named `{{ page.product_name }}-1` and note the IP address assigned to your device (e.g. `192.168.1.56`).

**WARNING:** In some office networks, DHCP may be configured to assign IP addresses only to known devices. If this is the case, ask your IT administrator to assign an IP address to your ModuCop. You will need the MAC address of your device, which can be found in the console log when booting the device.
{: .notice--warning}

#### Setup Static IP
To use a static IP address, configure the IP-Address, Gateway and Network Mask using the `static-ip` command. The three parameters have to be specified as a single string, separated by colons (`:`), `<ip>:<gateway>:<netmask`>`.

```
config> static-ip 192.168.1.56:192.168.24.1:255.255.255.0
Setting static-ip to '192.168.1.56:192.168.24.1:255.255.255.0'
A 'reboot' is required to activate the new setting!
```
Activate the changes:
```
config> reboot
```


#### Connection Test

Now try to test the connection using `ping` from a computer in the same network as your device. Use the IP address of your device:
```
$ ping 192.168.56.1
PING 192.168.1.56 (192.168.1.56) 56(84) bytes of data.
64 bytes from 192.168.1.56: icmp_seq=1 ttl=255 time=57.1 ms
64 bytes from 192.168.1.56: icmp_seq=2 ttl=255 time=76.4 ms
```
