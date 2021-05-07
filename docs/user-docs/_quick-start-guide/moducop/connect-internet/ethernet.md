---
title: Connect ModuCop to Internet using Local Ethernet
excerpt: Connect ModuCop to Internet using Local Ethernet
last_modified_at: 2021-04-21

custom_previous: /quick-start-guide/moducop/connect-to-terminal/
custom_next: /quick-start-guide/edgefarm/
---
# Using Your Local Network As the Internet Connection
If your local network provides access to the Internet, you are almost done. Just check if you could access the Internet.

In ModuCop's Linux Terminal, try to ping a server on the Internet. You should see a result like this:
```bash
root@moducop-cpu01:~# ping -c 4 www.wikipedia.com
PING www.wikipedia.com (91.198.174.194): 56 data bytes
64 bytes from 91.198.174.194: seq=0 ttl=54 time=28.742 ms
64 bytes from 91.198.174.194: seq=1 ttl=54 time=25.370 ms
64 bytes from 91.198.174.194: seq=2 ttl=54 time=34.584 ms
64 bytes from 91.198.174.194: seq=3 ttl=54 time=26.816 ms

--- www.wikipedia.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 25.370/28.878/34.584 ms
```

# Configure Ethernet Static Network Settings

Let's say you are currently in a lab, but want to prepare ModuCop for later use in another network, for example in a vehicle. In the vehicle, you don't have DHCP, so you have to configure static IP settings.

Example:

|-------------------------------|----------------|
| Desired IP Address of ModuCop | 192.168.24.220 |
| Network Gateway to Internet   | 192.168.24.1   |

Enter the following commands to reconfigure.

The configuration changes are not applied until you reboot. 
{: .notice--info}

```bash
# nmcli con mod "Wired connection 1"  ipv4.addresses 192.168.24.220/24
# nmcli con mod "Wired connection 1"  ipv4.gateway 192.168.24.1
# nmcli con mod "Wired connection 1"  ipv4.dns 8.8.8.8
# nmcli con mod "Wired connection 1"  ipv4.method "manual"
# reboot
``` 
After reboot, open a new ssh connection using the new configured static IP address. For this to work, the IP address of the development PC and the just configured IP address must be in the same network. If not, reconfigure your development PCs network address.

If you are using Windows, open system settings and configure network settings (German `Netzwerkeinstellungen anzeigen`). Then configure a static IP for your Ethernet adapter. This example uses a class C IPv4 address. In this case, the first 3 numbers of the IP address define the network, and the last number defines the host address within the network. So, your PC's IP address must be `192.168.24.x`, where `x` is a number between 1 and 254 and must be different from ModuCop's IP address:

![Connect with putty]({{ '/user-docs/images/moducop/quick-start-guide/windows-ethernet-static-ip.gif' | relative_url }})

If you are a Linux user, please consult your distribution's documentation on how to change your Ethernet IP address.

