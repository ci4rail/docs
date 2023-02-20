## CAN/COM Interface

The {{ page.product_name }} has a shared CAN/COM interface on the topmost D-Sub Connector. The interface can be used as a CAN interface or as a serial interface, but not both at the same time.

### Connection

CAN/COM port connector on {{ page.product_name }}:

![CAN/COM Port Connector]({{ '/user-docs/images/connectors/dsub9-female-horizontal.png' | relative_url }}){: style="width: 30%"}

Pin functionality as viewed from {{ page.product_name }}:

| Pin | Symbol  | Description                  |
| --- | ------- | ---------------------------- |
| 1   | COM_TX+ | RS485 positive transmit line |
| 2   | CAN_L   | CAN Signal (dominant low)    |
| 3   | GND_ISO | CAN/RS485 Ground             |
| 4   | COM_RX+ | RS485 positive receive line  |
| 5   | -       | not connected                |
| 6   | COM_TX- | RS485 negative transmit line |
| 7   | CAN_H   | CAN Signal (dominant high)   |
| 8   | -       | not connected                |
| 9   | COM_RX- | RS485 negative receive line  |


## COM Interface

### Features

* RS485-full-duplex or RS485-half-duplex
* Virtual tty support using [RFC2217](https://datatracker.ietf.org/doc/html/rfc2217)
* Appears as a standard tty device on Linux hosts
* Baudrates up to 460800 Baud
* Galvanic Isolation between the COM port and other ports

### Typical Connection Examples

![COM Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou06/com-conn.svg' | relative_url }}){: style="width: 60%"}

Important Notes:

For RS485/RS422 half-duplex operation, you must externally connect the COM ports Rx pins with the corresponding Tx pin
{: .notice--info}

In RS485/RS422 mode, please add termination resistors to the end of the line. The termination must be 120R at each end of the cable.
{: .notice--info}


{% include content/io4edge/ttynvt/detailed-description.md single_port="true" example_port_ext="com" example_port_num="10001" have_hwhandshake="false" %}

## CANBus Interface

{% capture link_to_static_busconfiguration %}
{{ page.url | append: "../quick-start-can-io4edge" | relative_url }}#busconfiguration
{% endcapture %}

{% capture link_to_socketcan_qs %}
{{ page.url | append: "../quick-start-socketcan" | relative_url }}
{% endcapture %}

{% include content/io4edge/canl2/detailed-description.md listenonly="false"  link_to_static_busconfiguration=link_to_static_busconfiguration link_to_socketcan_qs=link_to_socketcan_qs %}

## IBIS Interface

The {{ page.product_name }} has an IBIS interface in the middle D-Sub Connector.

### Connection

IBIS port connector on {{ page.product_name }}:

| Pin | Symbol | Description                        |
| --- | ------ | ---------------------------------- |
| 1   | U-     | Supply GND                         |
| 2   | -      | don't connect                      |
| 3   | -      | don't connect                      |
| 4   | Tx     | IBIS Master Send (`Aufrufbus`)     |
| 5   | U+     | Supply +24V (input)                |
| 6   | -      | don't connect                      |
| 7   | -      | don't connect                      |
| 8   | Rx     | IBIS Master Receive (`Antwortbus`) |
| 9   | -      | don't connect                      |


Typical connection:

![IBIS Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/ibis-conn.svg' | relative_url }}){: style="width: 20%"}

### IBIS Master

The IBIS master appears as a serial device on the Linux host and its device name is {{ page.example_device_name }}-ibis.

## Audio / Binary Outputs Interfaces

The {{ page.product_name }} has a shared Audio/Binary Outputs interface on the very bottom D-Sub Connector. Both interfaces can be used at the same time.

### Connection

| Pin | Symbol      | Description                    |
| --- | ----------- | ------------------------------ |
| 1   | LINE_IN+    | Audio Input Plus Pole          |
| 2   | LINE_OUT_R- | Right Audio Channel Minus Pole |
| 3   | LINE_OUT_L+ | Left Audio Channel Plus Pole   |
| 4   | BIN_OUT2    | Binary Output 2                |
| 5   | BIN_OUT1    | Binary Output 1                |
| 6   | LINE_IN-    | Audio Input Minus Pole         |
| 7   | LINE_OUT_R+ | Right Audio Channel Plus Pole  |
| 8   | LINE_OUT_L- | Left Audio Channel Minus Pole  |
| 9   | COMMON_GND  | Binary Output Common Ground    |

{% include content/io4edge/iou06-front/audio.md %}
