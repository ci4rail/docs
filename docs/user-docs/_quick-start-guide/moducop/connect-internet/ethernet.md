---
title: Connect Moducop to Internet using Wifi
excerpt: Connect Moducop to Internet using Wifi
last_modified_at: 2021-04-21
---



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
```
