## Establishing Host Connection and Power

ModuSio devices can be connected to the Network via Ethernet or Wifi. Please select the tab for your preferred option:

{% include content/tab/start.md tabs="Ethernet, Wifi" instance="qs1" %}

{% include content/tab/entry-start.md %}

### Ethernet: Network and Power Connection

When the {{ page.product_name }} is connected to the host via Ethernet, the power should be provided via Power-Over-Ethernet.

ModuSio devices are Class 2 (3,84–6,49 W) PoE powered devices. Connect the ModuSio Device to a PoE source that can supply class 2 devices. ModuSios expect the PoE power as phantom power, i.e. using the Ethernet Tx and Rx pins.

![PoE connection]({{ '/user-docs/images/edge-solutions/modusio/modusio-poe.svg' | relative_url }}){: style="width: 100%"}

{% include content/modusio/quick-start/initial-config.md %}

#### Select Ethernet as Host Interface

Configure the device for Ethernet operation. The device is configured for Ethernet when it is *NOT* configured for Wifi. So we clear Wifi settings:
```
config> wifi-ssid ""
Delete wifi-ssid
```

You can ignore the message: `Can't set wifi-ssid: ESP_ERR_NVS_NOT_FOUND`. This is normal if wifi has not been configured before.
{: .notice--info}

{% include content/modusio/quick-start/config-ip.md %}

{% include content/tab/entry-end.md %}




{% include content/tab/entry-start.md %}

### Wifi: Network and Power Connection

When using Wifi, supply the ModuSio by a power supply, capable of delivering 12V..24VDC, 5W. Use contacts 5+6 and 7+8 to supply the power. Polarity doesn't matter.

![Wifi connection]({{ '/user-docs/images/edge-solutions/modusio/modusio-wifi.svg' | relative_url }}){: style="width: 100%"}

{% include content/modusio/quick-start/initial-config.md %}

#### Select Wifi as Host Interface

Configure the device for Wifi operation. You need the Access Point's Name (SSID) and a password.
```
config> wifi-ssid my-access-point-name
config> wifi-pw my-secret-password
```
**WARNING:** It is not possible to connect to Access Points that don't require a password.
{: .notice--warning}


{% include content/modusio/quick-start/config-ip.md %}

#### Troubleshooting Wifi Connection

In case Wifi connection doesn't work, enter `reboot` in the `SERVICE` console and check the log messages.

Look for messages beginning with `wifi:` and `io4edge_net:`. In case of success, you see something like

```
...
I (848) wifi:connected with my-access-point-name, aid = 1, channel 6, BW20, bssid = ...
...
I (2573) io4edge_net: Got IP Address
I (2573) io4edge_net: ~~~~~~~~~~~
I (2573) io4edge_net: ETHIP:192.168.1.56
I (2574) io4edge_net: ETHMASK:255.255.255.0
I (2574) io4edge_net: ETHGW:192.168.1.1
I (2574) io4edge_net: ~~~~~~~~~~~
...
```

If connection establishment isn't successful, you see periodically something like this:
```
I (6954) io4edge_wifi: Disconnected, reconnect
```

You can also scan for available access points. To enable wifi scanning, just set a dummy access point name:
```
config> wifi-ssid foo
config> reboot
...
config> wifi-scan
Total APs scanned = 2
                                    SSID RSSI Channel
                                  slinky -47   6
                            OfficeRouter -53   1
```

{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}
