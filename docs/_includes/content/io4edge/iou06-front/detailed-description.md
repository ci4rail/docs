## CAN/COM Interface

The {{ page.product_name }} has a shared CAN/COM interface on the topmost D-Sub Connector. The interface can be used as a CAN interface or as a serial interface, but not both at the same time.

### Connection

CAN/COM port connector on {{ page.product_name }} (Rev. 0):

![CAN/COM Port Connector]({{ '/user-docs/images/connectors/dsub9-female-horizontal.png' | relative_url }}){: style="width: 30%"}

CAN/COM port connector on {{ page.product_name }} (Rev. 1):

![CAN/COM Port Connector]({{ '/user-docs/images/connectors/d-sub9-plug-horizontal.svg' | relative_url }}){: style="width: 30%"}

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

### Typical Connection Examples (Rev. 0)

![COM Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou06/com-layout0-conn.svg' | relative_url }}){: style="width: 60%"}


### Typical Connection Examples (Rev. 1)
![COM Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou06/com-layout1-conn.svg' | relative_url }}){: style="width: 60%"}

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

### Typical Connection Examples (Rev. 0)
![CANBus Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou06/can-layout0-conn.svg' | relative_url }}){: style="width: 30%"}

### Typical Connection Examples (Rev. 1)
![CANBus Port Connector]({{ 'user-docs/images/edge-solutions/moducop/io-modules/iou06/can-layout1-conn.svg' | relative_url }}){: style="width: 30%"}

{% capture link_to_socketcan_qs %}
{{ page.url | append: "../quick-start-socketcan" | relative_url }}
{% endcapture %}

{% include content/io4edge/canl2/detailed-description.md listenonly="false"  link_to_static_busconfiguration=link_to_static_busconfiguration link_to_socketcan_qs=link_to_socketcan_qs %}

## IBIS Interface

The {{ page.product_name }} has an IBIS interface in the middle D-Sub Connector.

### Connection

IBIS port connector on {{ page.product_name }}:

| Pin | Symbol     | Description                        |
| --- | ---------- | ---------------------------------- |
| 1   | U-         | Supply GND                         |
| 2   | SLV_Tx     | IBIS Slave Send (`Antwortbus`)     |
| 3   | SLV_Rx_GND | IBIS Slave Receive GND             |
| 4   | MST_Tx     | IBIS Master Send (`Aufrufbus`)     |
| 5   | U+         | Supply +24V (input)                |
| 6   | SLV_Tx_GND | IBIS Slave Send GND                |
| 7   | SLV_Rx     | IBIS Slave Receive (`Aufrufbus`)   |
| 8   | MST_Rx     | IBIS Master Receive (`Antwortbus`) |
| 9   | -          | don't connect                      |


Note: The IBIS Slave function is only available in Rev. 1
{: .notice--info}

### Typical IBIS Master connection:

![IBIS Master Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/ibis-master-conn.svg' | relative_url }}){: style="width: 20%"}

### Typical IBIS Slave connection (Only available in Rev. 1):
![IBIS Master Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/ibis-slave-conn.svg' | relative_url }}){: style="width: 30%"}

### IBIS Interface

Both the IBIS Master, and IBIS Slave appear as a serial device on the Linux host and its device name is `/dev/tty{{ page.example_device_name }}-ibis`, when the {{ page.product_name }} is the first IO-Module.

**Warning** On the {{ page.product_name }}, the IBIS Master and IBIS Slave **cannot be used at the same time**. Only one system should be connected and used on the {{ page.product_name }}.
{: .notice--warning}

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

## Binary Outputs

The {{ page.product_name }} has two binary outputs. The outputs are low side switching, so the load shall be connected to the positive supply voltage. The outputs are galvanically isolated from the rest of the IO-Module.

### Features

The {{ page.product_name }} has a binary output function block providing:
* 2 galvanically isolated channels from the rest of the IOU6-Module.
* Each pin can be only used as a binary output.
* Supply voltage of both channels may be between 12VDC and 36VDC.
* Switching capability of each pin is 100mA
* Overcurrent/Overload protection

### Typical Connection Examples

![Binary Output Connection]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou06/use-case-iou06-output.svg' | relative_url }}){: style="width: 40%"}

### Use Cases

#### Controlling Output Values

The API provides two methods to control channel output values
* Control a single pin
* Control multiple pins

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
Control a single pin:
```go
    // output high value on first channel
    err = c.SetOutput(0, true)
    // Reset output value on the first channel
    err = c.SetOutput(0, false)
```

Control multiple pins using a bit mask. The second parameter to `SetAllOutputs` is a mask that specifies which channels are affected:
```go
    // set first binary output to high, set second binary output to low.
    err := c.SetAllOutputs(0x1, 0x3)
```

The `SetOuput` and `SetAllOutputs` methods return an error if the channel number is out of range

<!--- GO END --->
**Information** On Revision 0 `high` value will not allow current to flow through the circuit and vise versa.
{: .notice--info}
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
Control a single pin:
```python
    # output high value on first channel
    binio_client.set_output(0, True)
    # output low value on second channel
    binio_client.set_output(1, False)
```

Control multiple pins using a bit mask. The second parameter to `set_all_outputs` is a mask that specifies which channels are affected:
```python
    # set first binary output to high, set second output to low.
    binio_client.set_all_outputs(0x1, 0x3)

```

The `set_output` and `set_all_outputs` methods raise a `RuntimeErrpr` if the channel number is out of range

<!--- PYTHON END --->
**Information** On Revision 0: `high` value will not allow current to flow through the circuit and vise versa.
{: .notice--info}

{% include content/tabv2/end.md %}

#### Overcurrent and Overload Handling
The Binary outputs are overcurrent and overload protected. In case an overcurrent condition is detected on one channel, the channel is disabled. To recover from the situation, remove the load completely to allow a relaxing time for the {{ page.product_name }} to function again.
