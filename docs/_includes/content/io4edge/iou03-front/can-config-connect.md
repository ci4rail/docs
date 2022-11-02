### Bus Configuration {#busconfiguration}

Bus Configuration must be set once to tell the {{ page.product_name }} about the CAN parameters. This configuration is saved *persistently* in the device. You only need to perform this configuration step once, it survives reboots and power cycles.

In this example, we assume your
* Bitrate is 125 kBit
* Sampling Point is 62.5%
* Synchronization Jump Width is 1
* Listen only mode is on (because the {{ page.product_name }} can't send)

Configure the device. You specify a string that has the form `bitrate:sampling-point/1000:sjw:listen-only`

**Warning** Always set the listen-only flag to `1` on the {{ page.product_name }}. Otherwise the device may try to send ACKs on the bus and this might result in incorrect behavior also on the receiver side.
{: .notice--warning}


On your {{target_name}}, run:
```bash
io4edge-cli -d {{ page.example_device_name }} set-parameter can-config 125000:625:1:1
```

{% if is_mio %}
Alternatively, you can define the CAN configuration via the `SERVICE` interface and the config menu:
```
config> can-config 125000:625:1:0
config> reboot
```
{% endif %}


#### Connecting

![CAN Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou03/can-conn.svg' | relative_url }}){: style="width: 30%"}

Connect CAN_L, CAN_H and GND_ISO to the CAN bus. Be sure to have correct termination of 120R at each end of the line.
