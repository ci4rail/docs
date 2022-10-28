## Serial Interfaces
The {{ page.product_name }} has two identical serial interfaces, labelled `COM1` and `COM2`.

### Features

* RS232 or RS485-full-duplex or RS485-half-duplex
* Virtual tty support using [RFC2217](https://datatracker.ietf.org/doc/html/rfc2217)
* Appears as a standard tty device on Linux hosts
* Baudrates up to 460800 Baud
* Galvanic Isolation between the COM port and other ports

### Connection

COM port connector on {{ page.product_name }}:

![COM Port Connector]({{ '/user-docs/images/connectors/dsub9-female-horizontal.png' | relative_url }}){: style="width: 30%"}


Pin functionality as viewed from {{ page.product_name }}:

| Pin | Symbol    | Description                             |
| --- | --------- | --------------------------------------- |
| 1   | RS485_TX+ | RS485 positive transmit line            |
| 2   | RS232_TXD | RS232 transmit line                     |
| 3   | RS232_RXD | RS232 receive line                      |
| 4   | RS485_RX+ | RS485 positive receive line             |
| 5   | GND       | Ground (isolated from other interfaces) |
| 6   | RS485_TX- | RS485 negative transmit line            |
| 7   | RS232_CTS | RS232 Clear to Send                     |
| 8   | RS232_RTS | RS232 Request to Send                   |
| 9   | RS485_RX- | RS485 negative receive line             |


### Typical Connection Examples

![COM Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou04/com-conn.svg' | relative_url }}){: style="width: 60%"}

Important Notes:

Whether to use RS232 or RS485 is solely defined by hardware connection. It is not defined by software configuration. However, hardware flowcontrol and half/full-duplex operation must be configured in software!
{: .notice--info}

For RS485/RS422 half-duplex operation, you must externally connect the COM ports Rx pins with the corresponding Tx pin
{: .notice--info}

In RS485/RS422 mode, please add termination resistors to the end of the line. The termination must be 120R at each end of the cable.
{: .notice--info}


{% include content/io4edge/ttynvt/detailed-description.md %}

## CANBus Interface

{% capture canbus_connector %}
Connection is done via 9-pin DSub plug:

| Pin | Symbol  | Description                |
| --- | ------- | -------------------------- |
| 1   | -       | Not connected              |
| 2   | CAN_L   | CAN Signal (dominant low)  |
| 3   | GND_ISO | CAN Ground                 |
| 4   | -       | Not connected              |
| 5   | SHIELD  | Shield                     |
| 6   | GND_ISO | CAN Ground                 |
| 7   | CAN_H   | CAN Signal (dominant high) |
| 8   | -       | Not connected              |
| 9   | -       | Not connected              |
{% endcapture %}

{% capture link_to_static_busconfiguration %}
{{ page.url | append: "../quick-start-can-io4edge" | relative_url }}#busconfiguration
{% endcapture %}

{% capture link_to_socketcan_qs %}
{{ page.url | append: "../quick-start-socketcan" | relative_url }}
{% endcapture %}

The {{ page.product_name }} has one CANBus interfaces, labelled `CAN`.
{% include content/io4edge/canl2/detailed-description.md listenonly="false" connector=canbus_connector link_to_static_busconfiguration=link_to_static_busconfiguration link_to_socketcan_qs=link_to_socketcan_qs %}
