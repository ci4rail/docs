---
title: Interfaces
excerpt: ModuCop Edge Computer Interfaces

custom_next: /edge-solutions/moducop/mounting-installation/
---


![Interfaces Overview]({{ '/user-docs/images/moducop/user-manual/moducop-4-slot-connector.svg' | relative_url }})

## PSU01 Power Supply Connector

Type: M12 4-pin A-coded, plug.
Mating connector: M12 4-pin A-coded, socket.

| Pin | Symbol | Description                                             |
| --- | ------ | ------------------------------------------------------- |
| 1   | +Vin   | Positive Supply Voltage                                 |
| 2   | On/Off | Ignition                                                |
| 3   | -Vin   | Negative Supply Voltage (internally connected to Pin 4) |
| 4   | -Vin   | Negative Supply Voltage (internally connected to Pin 3) |

Please connect `On/Off` to +Vin. The Ignition signal is currently not supported.

## PSU02 Power Supply Connector

Type: M12 5-pin A-coded, plug.
Mating connector: M12 5-pin A-coded, socket.

| Pin | Symbol   | Description                                             |
| --- | -------- | ------------------------------------------------------- |
| 1   | +Vin     | Positive Supply Voltage (internally connected to Pin2)  |
| 2   | +Vin     | Positive Supply Voltage (internally connected to Pin 1) |
| 3   | -Vin     | Negative Supply Voltage (internally connected to Pin 4) |
| 4   | -Vin     | Negative Supply Voltage (internally connected to Pin 3) |
| 5   | Ignition | Ignition                                                |

To enable the PSU02, `Ignition` must be connected to +Vin.
Pull this pin to ground to turn initiate a shutdown sequence.

**Warning** Shutdown via `Ignition` is must be supported by the operating system.
{: .notice--warning}

## CPU01 COM Port

The CPU01 has a RS232 interface via M12 connector for connecting serial devices. RS232 is galvanically isolated from the CPU01. Handshake lines CTS and RTS are available.

Under Linux, the device is available as `/dev/ttyS101-CPU01UC-com`.

Type: M12 5-pin A-coded, socket.
Mating connector: M12 5-pin A-coded, plug.

| Pin | Symbol  | Description                  |
| --- | ------- | ---------------------------- |
| 1   | GND_ISO | RS232 Ground                 |
| 2   | CTS     | RS232 CTS (input)            |
| 3   | TxD     | RS232 Transmit Data (output) |
| 4   | RTS     | RS232 RTS (output)           |
| 5   | RxD     | RS232 Receive Data (input)   |

## CPU01 USB 2.0 Port

The CPU01 has a USB 2.0 port via M12 connector for connecting USB devices. The CPU01 acts as a USB host. The interface is not galvanically isolated from the CPU01 logic.

Type: M12 4-pin A-coded, socket.
Mating connector: M12 4-pin A-coded, plug.

| Pin | Symbol | Description |
| --- | ------ | ----------- |
| 1   | VCC    | +5V         |
| 2   | D-     | Data-       |
| 3   | D+     | Data+       |
| 4   | GND    | Ground      |

## CPU01 Ethernet Ports

The CPU01 has two 10/100/1000BASE-T Ethernet ports via M12 connectors.

Under Linux, Interface labelled `ETH1` is available as `eth0`, Interface labelled `ETH2` is available as `enp5s0`.

Type: M12 8-pin X-coded, socket.
Mating connector: M12 8-pin X-coded, plug.

| Pin | Symbol | Description      |
| --- | ------ | ---------------- |
| 1   | A+     | Data Pair A, pos |
| 2   | A-     | Data Pair A, neg |
| 3   | B+     | Data Pair B, pos |
| 4   | B-     | Data Pair B, neg |
| 5   | D+     | Data Pair D, pos |
| 6   | D-     | Data Pair D, neg |
| 7   | C+     | Data Pair C, pos |
| 8   | C-     | Data Pair C, neg |

## CPU01 LTE Antenna Interfaces

The CPU01 has two LTE antenna interfaces via SMA connectors.

LTE1 is connected to the LTE Modem's `Main` antenna port.
LTE2 is connected to the LTE Modem's `Aux` antenna port.

## CPU01 WLAN Antenna Interfaces

The CPU01 has two LTE antenna interfaces via reverse SMA connectors.

WLAN1 is connected to the WLAN module's `Main` antenna port.
WLAN2 is connected to the WLAN module's `Aux` antenna port.

## CPU01 GNSS Antenna Interface

The CPU01 has a GNSS antenna interface via SMA connector.
Use active GNSS antennas only.

## CPU01 Interfaces under Service Cover

The following interfaces are accessible only when the service cover is removed.

![Service Interfaces]({{ '/user-docs/images/moducop/user-manual/service-interfaces-photo.svg' | relative_url }})

### CPU01 SIM Card Slots

The CPU01 has two nano-SIM card slots for LTE Modem SIM cards. The second SIM card slot is only usable if the LTE modem support dual SIM cards.

### CPU01 MicroSD Card Slot

The CPU01 has a MicroSD card slot for storage expansion.

Under Linux, the device is available as `/dev/mmcblk1`.

### CPU01 Console Port

The CPU01 has a console interface available via USB-to-Serial converter.
The interface is available via USB-C connector behind the service cover. Use a USB-C to USB-A cable to connect to a PC. USB-C to USB-C cables are not supported.

The default baud rate is 115200.

The interface is not galvanically isolated from the CPU01 logic.

### CPU01 USB Service Port

The CPU01 has a USB service port as USB OTG port. It is currently only supported for factory programming.


### CPU01 Battery Slot

To backup the RTC, the CPU01 has a battery slot for a battery. The battery type is CR11108, sometimes also called 1/3N, CR1/3N.
