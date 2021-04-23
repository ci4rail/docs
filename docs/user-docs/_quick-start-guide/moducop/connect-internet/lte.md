---
title: Connect Moducop to Internet using LTE
excerpt: Connect Moducop to Internet using mobile radio connection
last_modified_at: 2021-04-21

custom_previous: /quick-start-guide/moducop/connect-to-terminal/
custom_next: /quick-start-guide/login/
---
# Overview
In this section, you will use Moducops integrated LTE module to connect with the internet.

We will:
* Setup SIM Card
* Connect to the mobile Network
* Check Internet connection

We will use Linux ModemManager/Networkmanager and their command line tools `mmcli` and `nmcli`.

## Prerequisites

What you need:
* [ssh access]({{ '/quick-start-guide/moducop/connect-to-terminal' | relative_url }}) from your development PC to Moducops Linux Terminal
* At least one LTE Antenna
* Activated Nano SIM Card
  * Pin for your SIM Card
  * APN (access point name) for your SIM Card

# Step 1: Prepare Hardware

## Insert SIM Card

* Remove the service flap from Modcops front panel `TODO: Picture`.
* Insert a Nano SIM Card into the SIM Card slot `TODO: Picture`.

## Attach LTE Antenna
Attach LTE antenna to Moducops antenna connectors labelled `LTE1` and `LTE2`. One antenna is enough, a second antenna can improve signal quality.
`TODO: Picture`.

# Step 2: Unlock your SIM Card

Now, unlock your SIM card (disable PIN), so that Moducop can immediately establish the LTE connection after each startup.

From Moducops Linux Terminal, enter
```bash
# mmcli -m 0
```
This will list the status of the first Modem (we only have one, so `-m 0` is valid).

When the SIM has a pin, and the SIM is not yet unlocked, you will see the SIM state as `locked`:
```
  Status   |              lock: sim-pin
           |    unlock retries: sim-pin (3), sim-puk (10), sim-pin2 (3), sim-puk2 (10)
           |             state: locked
           |       power state: on
```
Now, you need your SIM pin!

To unlock the SIM, enter the
```bash
# mmcli -i 0 --disable-pin --pin=<pin>

successfully disabled PIN code request in the SIM
```

# Step 3: Create LTE Connection

In this step, you'll tell the NetworkManager that you want to connect via LTE to your provider.

Now, you need your APN name (e.g. something like `web.vodafone.de`).

```bash
# nmcli c add type gsm ifname * con-name lte apn <apn-name>
Connection 'lte' (7c444550-a259-4072-97af-b06c38152a45) successfully added.
```

# Step 4: Verify Your Setup

First, let's check the LTE signal quality:

```bash
# mmcli -m 0 
```

You should see something like this:
```
  --------------------------------
  Status   |                 lock: sim-pin2
           |       unlock retries: sim-pin (3), sim-puk (10), sim-pin2 (3), sim-puk2 (10)
           |                state: connected
           |          power state: on
           |          access tech: lte
           |       signal quality: 100% (recent)
```


Verify the IP address you have received from the mobile provider:

`nmcli` will show you all known network interfaces. Just look at the `cdc-wdm0` interface:

```bash
# nmcli
...
cdc-wdm0: connected to lte
        "cdc-wdm0"
        gsm (qmi_wwan, option1), hw, iface wwan0, mtu 1500
        inet4 <YOUR-IP>
        route4 100.70.25.32/28
        route4 0.0.0.0/0
...
```

**NOTE:** The connection settings you have entered are stored on Moducops internal disk. So, when you restart your Moducop, it will automatically re-connect to your mobile network.
{: .notice--info}

# Step 5: Verify Internet Connection
Now try to ping a server on the Internet. 
To ensure that we ping over mobile network, we specify the Wifi device with the `-I` option:

```bash
root@moducop-cpu01:~# ping -I wwan0 -c 4 www.wikipedia.com
```
You should see a result like this:
```
PING www.wikipedia.com (91.198.174.194): 56 data bytes
64 bytes from 91.198.174.194: seq=0 ttl=54 time=146.044 ms
64 bytes from 91.198.174.194: seq=1 ttl=54 time=49.958 ms
64 bytes from 91.198.174.194: seq=2 ttl=54 time=49.432 ms
64 bytes from 91.198.174.194: seq=3 ttl=54 time=48.603 ms

--- www.wikipedia.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 48.603/73.509/146.044 ms
```

`TODO: How to continue`