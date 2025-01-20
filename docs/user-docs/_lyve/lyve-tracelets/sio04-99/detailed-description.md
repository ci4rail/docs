---
title: SIO04-99 Detailed Description
excerpt: Detailed Description of the SIO04-99 functionality
last_modified_at: 2024-06-07

product_name: SIO04-99
article_group: S103
example_device_name: SIO04-99-1
---

## Introduction
The GNSS RTK precise positioning module SIO04-99 is a member of the KYT Sensor family by Ci4Rail and can work as a standalone device as well as in combination with ModuCop MEC0x.

The GNSS/RTK technology provides high precision positioning information without additional
infrastructure outdoors. The speed pulse input signal supports identification of distance traveled and movement direction. Specific movement models within an IMU (Inertial  Measurement Unit) allow smooth seamless real-time positioning.

The positioning information is transferred to in-vehicle subsystems via Ethernet interface.


## Detailed Technical Specification

| Feature                       |                                            Value                                            |
| :---------------------------- | :-----------------------------------------------------------------------------------------: |
| **Interfaces**                |
| Communication Interface       |                             100MBit/s Ethernet via M12 D-Coded                              |
| Service Interface             |                                 USB 2.0 via M12 8p A-Coded                                  |
| Positioning Outdoor           |                                     Multi-band GNSS/RTK                                     |
|                               |                                    GPS/QZSS (L1C/A L2C)                                     |
|                               |                                     GLONASS (L1OF L2OF)                                     |
|                               |                                     Galileo (E1B/C E5b)                                     |
|                               |                                      BeiDou (B1I B2I)                                       |
| Position accuracy             |         localization values have an accuracy of < 1m for 95% of the reported values         |
| Speed Pulse Signal            |                   acc. to IEC 16844-2 (input high: 4,8V; input low: 2,2V)                   |
| Ignition                      |                          On State: Input high: 5,2 V (min) or open                          |
|                               |                 Standby State (after delay ~3 sec): Input low: 3,6 V (max)                  |
| Antenna                       |                                            TODO                                             |
| **Maintenance**               |
| Firmware update               |                                        Via USB, LAN                                         |
| Management                    |          Via io4edge protocol, see [io4edge protocol]({{ '/edge-solutions/io4edge'          | relative_url }}) |
| **Electrical**                |
| Power Supply                  |                            Power-over-Ethernet (PoE PD) class 1                             |
|                               |                 12V, 24V (nom.) acc. to ISO 7637-2:2011 via M12 8p A-Coded                  |
| Power Consumption             |                                    Operation typ. < 3 W                                     |
|                               |                                    Standby State < 0,1 W                                    |
| **Mechanics**                 |                                                                                             |
| Dimensions (w/o mounting acc) |                                       Width: 110.0 mm                                       |
|                               |                                       Depth: 98.0 mm                                        |
|                               |                                       Height: 48.0 mm                                       |
| Mounting                      |    Flexible Mounting via integrated mounting holes or vehicle specific mounting adapter     |
|                               |     Horizontal mounting on vehicle roof with connector in backwards or CAB B direction      |
| Ingress Protection            |                                            IP40                                             |
| **Environmental**             |
| Operating                     |                               -40…+70°C (EN 50155:2021 - OT4)                               |
| Storage Temperature           |                                          -40…+85°C                                          |
| Humidity                      |                                    95% (EN 50155-1:2021)                                    |
| Altitude                      |                   3000 m max. above sea level (EN 50125-1:2014, class AX)                   |
| Shock / Vibration             |                               EN 61373:2010; Cat. 1; Class B                                |
| EMC Emission / Immunity       |                     EN 50121-3-2:2016; EMV 06 Class S1 / ECE R10 Rev.6                      |
| Safety                        | EN 50155:2017; EN 50153:2014+A1:2017; EN 50124-1:2017; EN 62368-1:2016; EN ISO 13732-1:2008 |
| Fire & Smoke                  |                               EN 45545-2:2013 + A1:2015; HL3                                |
| Useful Life                   |                             20 years (EN 50155:2017, class L4)                              |
| Certifications                |                                CE / UN ECE R10 (E-Mark) TODO                                |



# Connections

SIO04-99 provides two M12 interface connectors for roboust and IP protected connections.
The product offers an M12-8pin A-coded connector for shared power and service interfaces as well as an M12-4pin D-coded Ethernet interface connector.

## M12-8pin A-coded, socket:
* alt. power supply 12V / 24V DC (nom)
* Ignition
* Wheeltick Input
* USB-Service Interface

Mating connector: M12 8-pin A-coded, plug.

![Lyve Tracelet]({{ '/user-docs/images/connectors/M12-8pol-A-female-pinning.png' | relative_url }}){: style="width: 50%"}

| Pin | Symbol | Description               |
| --- | ------ | ------------------------- |
| 1   | V_IN   | 12/24V Power Supply Input |
| 2   | WT     | Wheeltic input            |
| 3   | IGN    | Ignition                  |
| 4   | USB-   | USB Dataline -            |
| 5   | GND    | Ground                    |
| 6   | GND    | Ground                    |
| 7   | V_USB  | USB Power Supply Input    |
| 8   | USB+   | USB Dataline +            |

## M12-4pin D-coded, socket:
* 100 MBit/s Ethernet; Power Over Ethernet

Mating connector: M12 4-pin DA-coded, plug.

![Lyve Tracelet]({{ '/user-docs/images/connectors/M12-4pol-D-female-pinning.png' | relative_url }}){: style="width: 50%"}



| Pin | Symbol | Description |
| --- | ------ | ----------- |
| 1   | TxD+   | CT (PoE)    |
| 2   | RxD+   | CT (PoE)    |
| 3   | TxD-   | CR (PoE)    |
| 4   | RxD-   | CR (PoE)    |


# Mechanical Outline

The product has the following dimensions

| Dimension | Value    |
| --------- | -------- |
| Width     | 70.6 mm  |
| Depth     | 80.0 mm  |
| Height    | 111.5 mm |


# Mounting & Installation

TODO

## Installation Requirements

TODO
