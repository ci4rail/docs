## Establishing Host Connection and Power

ModuSio devices can be connected to the Network via Ethernet or Wifi. Please select the tab for your preferred option:

{% include content/tab/start.md tabs="Ethernet, Wifi" instance="qs1" %}

{% include content/tab/entry-start.md %}

### Network and Power Connection

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

When using Wifi, supply the ModuSio by a power supply, capable of delivering 12V..24VDC, 5W. Use contacts 5+6 and 7+8 to supply the power. Polarity doesn't matter.

For initial configuration, connect the `SERVICE` interface to a computer using a USB cable.

![Wifi connection]({{ '/user-docs/images/edge-solutions/modusio/modusio-wifi.svg' | relative_url }}){: style="width: 100%"}

{% include content/modusio/quick-start/initial-config.md %}

#### Select Wifi as Host Interface

Configure the device for Wifi operation. You need the Access Point's Name (SSID) and a password.
```
config> wifi-ssid my-access-point-name
config> wifi-pw my-secret-password
```
{% include content/modusio/quick-start/config-ip.md %}


{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}
