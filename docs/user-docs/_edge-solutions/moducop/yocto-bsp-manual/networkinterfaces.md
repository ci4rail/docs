---
title: Network Interfaces
excerpt: How to use the network interfaces of the ModuCop Edge Computer
order: 60
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The ModuCop Edge Computer MEC01 provides several network interfaces to connect to the outside world. This section describes how to use these interfaces.

## Ethernet

ModuCop MEC01 provides two Ethernet interfaces, labelled ETH1 and ETH2 on the front panel.

In some variants of the MEC01, the ETH2 interface is not populated.
{: .notice--warning}

Both are 1Gbit Ethernet interfaces, which can be used to connect to a network switch or router. The interfaces are configured via NetworkManager, which is the default network management tool in the ModuCop Yocto BSP.

The interface names in linux are
- `end0` for ETH1
- `enp5s0` for ETH2

The default configurations are:

| Interface | Configuration              |
| --------- | -------------------------- |
| ETH1      | DHCP                       |
| ETH2      | Fixed IP: 192.168.25.99/24 |

If you don't want the fixed IP configuration for ETH2, you can just delete the configuration for it.

```bash
rm /etc/NetworkManager/system-connections/eth2.connection
```
Afterwards, it will be configured via DHCP like ETH1.

## WiFi

The ModuCop MEC01 provides a WiFi interface, which is supporting both 2.4GHz and 5GHz bands. It can operate in both client and access point mode, even simultaneously.

### Antenna configuration

On the MEC01 front, you see two antenna connectors, labelled `WLAN1` and `WLAN2`. These are the antenna connectors for the WiFi interface. You can use either one or both of them, depending on your use case.

By default, both antenna connectors are enabled. However, if you only want to use one antenna (`WLAN1`), you must configure the WiFi interface accordingly. In this case, call

```bash
iw phy phy0 set antenna 0x1 0x1
```

This setting is not persistent across reboots, so you may want to add it to a systemd service or script that runs at boot time.
{: .notice--warning}

If you use only one antenna and you do not set the antenna configuration, the WiFi interface will still work, but it may not perform optimally.
{: .notice--warning}

### Display available WiFi networks

To list all available WiFi networks, you can use the `nmcli` command:

```bash
nmcli --colors no dev wifi list
```

This will show you a list of all available WiFi networks, including their SSID, signal strength, and security type.

The `--colors no` option disables colored output, which works around an issue with the busybox shell. You should use this option every time you use `nmcli` in the ModuCop Yocto BSP.
{: .notice--info}

### Connect to a WiFi network (Client Mode)

The network interface for client mode is called `mlan0`. To connect to a WiFi network, you can use the `nmcli` command:

```bash
nmcli -a device wifi connect your-ssid
Password: **************
Device 'mlan0' successfully activated with '50cf3ec8-fe0a-40cb-8f55-4e2d17ce7d2d
```

Now you should be able to ping a host on the wi-fi network, for example:

```bash
ping <host-ip> -I mlan0
```

### Disconnect from a WiFi network

```bash
nmcli device disconnect mlan0
```

### Configure WiFi in Access Point Mode

The network interface for access point mode is called `uap0`.

To configure the WiFi as an access point, you may use the following `nmcli` commands. Replace `<your-ssid>`, `<your-channel>`, and `<your-password>` with your desired values:

```bash
nmcli con add type wifi ifname uap0 mode ap con-name WIFI_AP ssid <your-ssid>
nmcli con modify WIFI_AP 802-11-wireless.band bg
nmcli con modify WIFI_AP 802-11-wireless.channel <your-channel>
nmcli con modify WIFI_AP 802-11-wireless-security.key-mgmt wpa-psk
nmcli con modify WIFI_AP 802-11-wireless-security.proto rsn
nmcli con modify WIFI_AP 802-11-wireless-security.psk <your-password>
nmcli con modify WIFI_AP ipv4.method shared
nmcli con up WIFI_AP
```

To provide a DHCP server for the connected clients, the `ipv4.method` is set to `shared`. This allows the MEC01 to act as a WiFi access point, providing network connectivity to connected devices.

## Cellular
