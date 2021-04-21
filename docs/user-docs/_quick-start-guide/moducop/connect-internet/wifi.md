---
title: Connect Moducop to Internet using local Ethernet Network
excerpt: Connect Moducop to Internet using local Ethernet Network
last_modified_at: 2021-04-21
---
# Overview
In the [previous chapter]({{ '/quick-start-guide/moducop/connect-to-terminal' | relative_url }}), you connected Moducop with your local network and you have connection to Moducops Linux terminal from your development PC via `ssh`.

In this section, you will use Moducops integrated Wifi module to connect with the internet.

We will:
* Scan for Wifi networks
* Connect to a Wifi access point
* Check Internet connection

We will use Linux Networkmanager and its command line tool `nmcli`.

## Prerequisites
* ssh access from your development PC to Moducops Linux Terminal
* At least one Wifi Antenna
* Wifi Access Point that provides Internet connection

# Step 1: 


If your local network provides access to the Internet, you are are almost done. Just check if you could access the Internet.

In Moducops Linux Terminal, try to ping a server on the Internet. You should see a result like this:
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