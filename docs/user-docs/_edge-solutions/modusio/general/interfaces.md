---
title: ModuSIO Common Interfaces
excerpt: Interfaces common to all ModuSIOs

---

## POWER/ETH Connector

All ModuSio have a POWER/ETH connector. The connector has pins for the 10/100 MBits Ethernet interface and pins to supply power to the ModuSio.

Type: M12 8-pin X-coded, socket.
Mating connector: M12 8-pin X-coded, plug.


![POWER/ETH Connector]({{ '/user-docs/images/connectors/m12-female-x-coded.png' | relative_url }})

| Pin | Symbol | Description                                     |
| --- | ------ | ----------------------------------------------- |
| 1   | TXC+   | Ethernet positive Output from ModuSio           |
| 2   | TXC-   | Ethernet positive Output from ModuSio           |
| 3   | RXC+   | Ethernet negative Input to ModuSio              |
| 4   | RXC-   | Ethernet negative Input to ModuSio              |
| 5   | V1     | Power Supply Input, Line1 (connected with Pin6) |
| 6   | V1     | Power Supply Input, Line1 (connected with Pin5) |
| 7   | V2     | Power Supply Input, Line2 (connected with Pin8) |
| 8   | V2     | Power Supply Input, Line2 (connected with Pin7) |

In case of a 24V power supply, you can connect the positive voltage to Pin 5/6 and the GND to Pin 7/8.
The polarity doesn't actually mattern, as the ModuSio has an iternal rectifier.

## Service Connector

The Service Connector is a USB type C connector. It provides access to a Silicon Labs CP2102N UART to USB converter. The UART is connected to the ModuSio's console.

It is possible to power the ModuSio via the Service Connector. The ModuSio will be powered by the USB 5V supply.

Powering the ModuSio via the Service Connector is only intended for provisioning and testing purposes. It is not intended for permanent operation.
