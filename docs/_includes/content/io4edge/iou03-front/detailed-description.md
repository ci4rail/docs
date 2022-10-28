## MVB Sniffer
{% include content/io4edge/mvbsniffer/detailed-description.md %}

## CANBus Interface

{% capture canbus_connector %}
Connection is done via 9-pin DSub plug. On the same connector, a RS485 interface is available, which is not used by the CANBus interface.

| Pin | Symbol    | Description                |
| --- | --------- | -------------------------- |
| 1   | -         | Not connected              |
| 2   | CAN_L     | CAN Signal (dominant low)  |
| 3   | GND_ISO   | CAN Ground                 |
| 4   | RS485_RX+ | Not used by CAN Interface  |
| 5   | SHIELD    | Shield                     |
| 6   | GND_ISO   | CAN Ground                 |
| 7   | CAN_H     | CAN Signal (dominant high) |
| 8   | -         | Not connected              |
| 9   | RS485_RX- | Not used by CAN Interface  |
{% endcapture %}

{% capture link_to_static_busconfiguration %}
{{ page.url | append: "../quick-start-guide" | relative_url }}#busconfiguration
{% endcapture %}

{% capture link_to_socketcan_qs %}
{{ page.url | append: "../quick-start-guide" | relative_url }}#socketcandemo
{% endcapture %}


The {{ page.product_name }} has one CANBus interfaces, labelled `FB LO`.
{% include content/io4edge/canl2/detailed-description.md listenonly="true" connector=canbus_connector link_to_static_busconfiguration=link_to_static_busconfiguration link_to_socketcan_qs=link_to_socketcan_qs %}
