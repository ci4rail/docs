---
title: Run Demo
excerpt: How to run the demo
custom_previous: /lyve/lyve-demo-kit-rev-0/configure-tracelet/
---

## Pre-checks

We assume that you have
* Installed the software on your PC
* Configured the tracelet
* Connected the Tracelet to the LTE/WLAN Router
* Installed the Tracelet on the Vehicle
* Power Bank is powered on

## Check position in Easyplan

Open Easyplan and select your Site (Building).

Click on the "Positioning" Icon (at the bottom right corner), then on "Start Remote Positioning".

You should see the position of the vehicle on the map.

Easyplan vizualises three different positions:
* Orange: Position from UWB Subsystem
* Blue: Position from GNSS Subsystem
* Purple: Fused Position

![Easyplan Markers](/user-docs/images/lyve/easyplan-markers.png){: style="width: 50%"}

## Check quality metrics in Grafana

[Open Grafana in your browser](http://localhost:3000), then navigate to the "Single Tracelet Details" dashboard.

You should see the quality metrics for the selected Tracelet.

Explanation of the quality metrics (only those relevant for users):

| Metric                                | Description                                                                                                                              |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Wifi Strength                         | The strength of the Wi-Fi signal received by the Tracelet. As a second metric, the last two bytes of the MAC address of the connected AP |
| Connected to Localization Server      | Indicates whether the Tracelet is connected to the localization server (your PC)                                                         |
| Missing Acks from Localization Server | Many lost ACKs indicate a weak connection to the localization server.                                                                    |
| Connected to NTRIP Caster             | Indicates whether the Tracelet is connected to the NTRIP caster.                                                                         |
| Sensor Fusion State                   | Indicates which system is used for the fused position (UWB/GNSS)                                                                         |
| GNSS/Satellites in View               | The number of satellites currently in view of the Tracelet per constellation.                                                            |
| GNSS/GNSS Reference Station           | The ID of the GNSS reference station to which the Tracelet is connected.                                                                 |
| GNSS/Sensor Fusion Status             | Indicates whether the GNSS Sensor fusion algorithm is active and functioning properly.                                                   |
| GNSS/Programmable Gain Amplifier      | The current gain setting of the programmable gain amplifier (PGA) used in the GNSS receiver.                                             |
| GNSS/Heading                          | The current heading (of motion and of vehicle) relative to north from GNSS subsystem                                                     |
| GNSS/Fix Type                         | The type of GNSS fix currently being used (e.g., 2D, 3D, RTK)                                                                            |
| GNSS/Boot Type                        | The type of last boot (e.g., cold, backup, software)                                                                                     |
| GNSS/Accuracy                         | The estimated accuracy of the GNSS position fix (in meters)                                                                              |
| GNSS/Speed                            | Speed reported by GNSS subsystem                                                                                                         |
| UWB/Fix Type                          | The type of UWB fix currently being used (UWB or DR)                                                                                     |
| UWB/X- and Y-Position                 | The current X and Y position reported by the UWB subsystem (in meters)                                                                   |
| UWB/Horizontal Position Error         | The current horizontal position error reported by the UWB subsystem (in meters)                                                          |
| UWB/Position Validity                 | Indicates whether the UWB position is valid or not.                                                                                      |
| Tacho/Vehicle Speed                   | Speed from Tacho signal                                                                                                                  |
| Tacho/Mileage                         | Distance covered by the vehicle according to the Tacho signal (in kilometers)                                                            |
| Ignition                              | Indicates whether the vehicle ignition is on or off                                                                                      |

## Test drive

### Testing GNSS Positioning

Place your vehicle in a location with clear sky view. Keep the position static for a few minutes.

You should see the blue position marker in Easyplan.

Check the following quality metrics in Grafana:
* Check "Connected to NTRIP Caster": Should be true
* Check "GNSS/Fix Type": Should be "RTK"
* Check "GNSS/Satellites in View": Used number of satellites should be >25
* Check "GNSS/Accuracy": Should be <1m

Then start to move the vehicle. Drive in a straight line for a few hundred meters, then perform some curves.

Check Grafana Metrics
* "Tacho/Vehicle Speed ": Should be consistent with the vehicle's actual speed
* "GNSS/Sensor Fusion Status": Should be "FUSION"

In Easyplan
* Recorded Track should match the vehicle's actual path

### Testing UWB Positioning

Move the vehicle into the area covered by UWB Satlets.

You should see the orange position marker in Easyplan.

### Handover from UWB to GNSS

Drive the Vehicle from the UWB covered area into an outside area.

You should see that the UWB track is continued even when leaving the UWB covered area until it gets too inaccurate.
When GNSS is available again, the fused position will switch to the GNSS position.

Note: The current implementation of UWB dead reckoning has a restriction: When the vehicle speed drops to 0 and later to >0, UWB dead reckoning stops.

### Handover from GNSS to UWB

Drive the Vehicle from outside the area into the UWB covered area.

You should see that the GNSS track is continued even when leaving the GNSS covered area.
Once UWB is available, the fused position will switch to the UWB position.
