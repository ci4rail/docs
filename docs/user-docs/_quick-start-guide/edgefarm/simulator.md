---
title: Using the Simulator
excerpt: Using the Simulator
last_modified_at: 2021-05-06

custom_previous: /quick-start-guide/edgefarm/basic-functions/
custom_next: /quick-start-guide/edgefarm/simulator/prerequisites/
---

The `Train Simulator Demo` simulates subsets of sensors and bus systems typically found in trains. 
This demo shows how EdgeFarm components work and how they interact.

Here you find a basic image on how the different parts of the simulation interact with each other.

![Basic Train Simulator Demo architecture]({{ 'user-docs/images/edgefarm/simulator/demo-arch.svg' | relative_url }} "Basic Train Simulator Demo architecture"){: style="width: 50%"}

The simulator is setup on a Windows or Linux machine that must be able to communicate with the edge device in the same network.
Once the simulator is up and running it sends simulated data to an MQTT broker. The application module `alm-mqtt-module` running on the device listens to the MQTT topics from the simulator. It then redirects the received messages directly to the specific demo application module `edge-demo` where the data can be handeled.
