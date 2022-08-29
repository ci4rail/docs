#### Configure IP Address

The ModuSio needs an IP address in the network. It can be configured to use a static IP address or to use dynamic IP address, provided by a DHCP server.

##### Setup for DHCP
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

##### Setup Static IP
To use a static IP address, configure the IP-Address, Gateway and Network Mask using the `static-ip` command. The three parameters have to be specified as a single string, separated by colons (`:`), `<ip>:<netmask>:<gateway>`>`.

```
config> static-ip 192.168.1.56:255.255.255.0:192.168.1.1
Setting static-ip to '192.168.1.56:255.255.255.0:192.168.1.1'
A 'reboot' is required to activate the new setting!
```
Activate the changes:
```
config> reboot
```

##### Connection Test

Now try to test the connection using `ping` from a computer in the same network as your device. Use the device ID of your device and append `.local`.
```
$ ping {{ page.product_name }}-1.local
PING {{ page.product_name }}-1.local (192.168.1.56) 56(84) bytes of data.
64 bytes from 192.168.1.56: icmp_seq=1 ttl=255 time=57.1 ms
64 bytes from 192.168.1.56: icmp_seq=2 ttl=255 time=76.4 ms
```
