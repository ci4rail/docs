---
title: Specification
excerpt: Technical Features of ModuCop Edge Computer.
last_modified_at: 2021-11-08

custom_next: /edge-solutions/moducop/general/mech-outline/
---

This page provides information about the technical specification of ModuCop Edge Computer.

![ModuCop Edge Computer]({{ '/user-docs/images/edge-solutions/moducop/42HP15_trans1.jpg' | relative_url }})


## Features
* ARM® Cortex A53 Quad-Core, ARM® Cortex M4F
* 2 GB DDR4; 16 GB eMMC
* 2x 1GB/s Ethernet, 1x USB 2.0, 1x RS232
* Integrated WLAN, LTE, GNSS
* Expandable by modular extension units
* Variable housing 3 slot to 12 slot
* Linux Microservices Platform
* EN 50155 and E1 qualified


## Detailed Technical Specification

| Feature                         |                                            Value                                            | S100-MEC01- (Rail) | S100-MEC02- (Automotive) |
| :------------------------------ | :-----------------------------------------------------------------------------------------: | :----------------: | :----------------------: |
| **System**                      |                                                                                             |                    |                          |
| CPU                             |                              ARM Cortex A53 Quad Core 1,6 Ghz                               |         x          |            x             |
| Main Memory                     |                                          2 GB DDR4                                          |         x          |            x             |
| Storage                         |                                         16 GB eMMC                                          |         x          |            x             |
| Power Input                     |                         24...110V DC nom. (EN 50155:2017 Class S2)                          |         x          |                          |
|                                 |                              9...36V DC nom. (ISO 7637-2:2011)                              |                    |            x             |
| Input / Output                  |                            2x 1GB/s Ethernet via 8p M12 X-coded                             |         x          |            x             |
|                                 |                               1x USB 2.0 via 4p M12 A-coded;                                |         x          |            x             |
|                                 |                                 1x RS232 via 5p M12 A-coded                                 |         x          |            x             |
| Wireless                        |                     Wi-Fi IEEE 802.11 ac/a/b/g/n via 2x RP-SMA antenna;                     |         x          |            x             |
|                                 |                       GPS (incl. dead reckoning) via 1x SMA antenna;                        |         x          |            x             |
|                                 |                              LTE (optional) via 2x SMA antenna                              |        (x)         |           (x)            |
|                                 |                            LoRaWan (optional) via 1x SMA antenna                            |        (x)         |           (x)            |
| Maintenance (Front Accessible)  |                                       1x Slot for μSD                                       |         x          |            x             |
|                                 |                                      1x Nano-SIM Slot                                       |         x          |            x             |
|                                 |                                  1x USB Service via Type C                                  |         x          |            x             |
|                                 |                               1x UART Service via USB Type C                                |         x          |            x             |
| Security                        |                                     Integrated TPM 2.0                                      |         x          |            x             |
| Miscellaneous                   |                               Integrated 3-axis accelerometer                               |         x          |            x             |
| **I/O Extensions**              |                                                                                             |                    |                          |
| Extensibility                   |                        Modular configuration by I/O extension units                         |         x          |            x             |
|                                 |                                1 extension (4 slot / 28 HP)                                 |         x          |            x             |
|                                 |                                3 extensions (6 slot / 42 HP)                                |         x          |            x             |
|                                 |                            up to 9 extensions (12 slot / 84 HP)                             |         x          |            x             |
|                                 |    Functional extension to MVB, BIN I/O, CAN, IBIS, Serial IF, RTEthernet …. (optional)     |        (x)         |           (x)            |
| **Mechanics**                   |                                                                                             |                    |                          |
| Dimensions (w/o mounting acc)   |               Width: 142.3 mm (4 slot); 213.2 mm (6 slot); 426.8 mm (12 slot)               |         x          |            x             |
|                                 |                                       Depth: 61.2 mm                                        |         x          |            x             |
|                                 |                                      Height: 111.5 mm                                       |         x          |            x             |
| Mounting                        |              DIN Rail, wall mounting, 19‘‘ sub-rack mounting (see accessories)              |         x          |            x             |
| **Environmental**               |                                                                                             |                    |                          |
| Operating / Storage Temperature |      -40…+70°C / 85°C (10min) (EN 50155:2017 - OT4 + ST1) / -40…+85°C (EN 50155:2017)       |         x          |            x             |
| Humidity                        |                                    95% (EN 50125-1:2014)                                    |         x          |            x             |
| Altitude                        |                   3000 m max. above sea level (EN 50125-1:2014, class AX)                   |         x          |            x             |
| Shock / Vibration               |                               EN 61373:2010; Cat. 1; Class B                                |         x          |            x             |
| EMC Emission / Immunity         |               EN 50121-3-2:2016; EMV 06 (2.0) Class S1;EN 301 489-1 (V2.2.3)                |         x          |                          |
|                                 |                                        ECE R10 Rev.5                                        |                    |            x             |
| Safety                          | EN 50155:2017; EN 50153:2014+A1:2017; EN 50124-1:2017; EN 62368-1:2016; EN ISO 13732-1:2008 |         x          |            x             |
| Fire & Smoke                    |                               EN 45545-2:2013 + A1:2015; HL3                                |         x          |                          |
|                                 |                                          ECE R118                                           |                    |            x             |
| Useful Life                     |                             20 years (EN 50155:2017, class L4)                              |         x          |            x             |
| Pollution Degree                |                                    PD2 (EN 50124-1:2017)                                    |         x          |            x             |
| Certifications                  |                                             CE                                              |         x          |                          |
|                                 |                                     UN ECE R10 (E-Mark)                                     |                    |            x             |


For further information on technical specification - especially for I/O modules - please refer to our [Download Section](https://www.ci4rail.com/news/downloads)
