---
title: Connect Moducop to Internet using Wifi
excerpt: Connect Moducop to Internet using Wifi
last_modified_at: 2021-04-21
---
# Overview
In this section, you will use Moducops integrated Wifi module to connect with the internet.

We will:
* Scan for Wifi networks
* Connect to a Wifi access point
* Check Internet connection

We will use Linux Networkmanager and its command line tool `nmcli`.

## Prerequisites

What you need:
* [ssh access]({{ '/quick-start-guide/moducop/connect-to-terminal' | relative_url }}) from your development PC to Moducops Linux Terminal
* At least one Wifi Antenna
* Wifi Access Point that provides Internet connection
* Password for your Wifi Access point

# Step 1: Attach Wifi Antenna

Attach Wifi antenna to Moducops antenna connectors labelled `WLAN1` and `WLAN2`. One antenna is enough, a second antenna can improve Wifi quality.
`TODO: Picture`.


# Step 2: Scan for Wifi Access Points

Run the command below to see the available wifi access points. Wait for the output message.

The access point that should be used for your Internet connection shall appear in the list:
```bash
# nmcli device wifi list ifname mlan0 
IN-USE  BSSID              SSID                         MODE   CHAN  RATE        SIGNAL  BARS  SECURITY
        46:4E:6D:DB:C2:97  Ci4Rail-Guest                Infra  1     260 Mbit/s  100     ****  WPA2
        44:4E:6D:DB:C2:97  Ci4Rail-Office               Infra  1     260 Mbit/s  100     ****  WPA2
        02:A0:57:2A:DD:62  INTERN                       Infra  6     130 Mbit/s  32      **    WPA2
```

# Step 3: Connect with your Access Point
Now connect to your access point using the SSID of the access point (Ci4Rail-Office in this example) and the corresponding password:
```bash
# nmcli -a device wifi connect Ci4Rail-Office
Password: *************
Device 'mlan0' successfully activated with 'a881a567-c87b-4fec-add1-a08360bf99b8'.
```

Verify the IP address you have received from the DHCP server inside the Wifi access point:

`nmcli` will show you all known network interfaces. Just look at the `mlan0` interface:

```bash
# nmcli
...
mlan0: connected to Ci4Rail-Office
        "Marvell Wi-Fi"
        wifi (mwifiex_sdio), D8:C0:A6:5F:9B:63, hw, mtu 1500
        inet4 <YOUR-IP>
        route4 0.0.0.0/0
        route4 <YOUR-NET>
        inet6 <YOUR-IPV6>
        route6 fe80::/64
        route6 ff00::/8
...
```
Please record the assigned IP address in `<YOUR-IP>`. We'll use it later in [step 5](#step-5)

**NOTE:** The connection settings you have entered are stored on Moducops internal disk. So, when you restart your Moducop, it will automatically re-connect to your Wifi access point.
{: .notice--info}

# Step 4: Verify Internet Connection
Now try to ping a server on the Internet. 
To ensure that we ping over Wifi, we specify the Wifi device with the `-I` option:

```bash
root@moducop-cpu01:~# ping -I mlan0 -c 4 www.wikipedia.com
```
You should see a result like this:
```
PING www.wikipedia.com (91.198.174.194): 56 data bytes
64 bytes from 91.198.174.194: seq=0 ttl=55 time=81.814 ms
64 bytes from 91.198.174.194: seq=1 ttl=55 time=104.794 ms
64 bytes from 91.198.174.194: seq=2 ttl=55 time=128.140 ms
64 bytes from 91.198.174.194: seq=3 ttl=55 time=48.950 ms

--- www.wikipedia.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 48.950/90.924/128.140 ms
```

# Step 5: Get Rid of Ethernet
Now, as you have a wifi connection, you may get rid of the Ethernet cable you have used to configure Moducop. However, if you want to access Moducops Linux terminal later from your development PC, your development PC must also be in the access point's Wifi network.

Now Disconnect your Ethernet Cable.

On your development PC, start a new ssh session, but now enter Moducops IP address on the Wifi network, you have noted in [step 3](#step-3).

You should be able to login as `root` with the standard password `cheesebread`.