---
title: Use the Train-Simulator-Demo
excerpt: Use the Train-Simulator-Demo
last_modified_at: 2021-07-09

custom_previous: /quick-start-guide/edgefarm/basic-functions/
custom_next: /quick-start-guide/edgefarm/simulator/prerequisites/
---

The `Train Simulator Demo` has been designed to experience the complete data chain from simulation of realistic train data, acquisition in the edge device, transfer to cloud and both visualization in dashboards and export to external data systems. The simulated data vary from simple diagnosis data via train network messages to high frequent measurement data.

With this demonstrator, you will get an impression how EdgeFarm components work and how they interact.

The following image shows how the different parts of the simulation interact with each other.

![Basic Train Simulator Demo architecture]({{ 'user-docs/images/edgefarm/simulator/demo-arch.svg' | relative_url }} "Basic Train Simulator Demo architecture"){: style="width: 50%"}

While the data acquistion and pre-processing will be executed on the edge device, the simulator has to be setup on a Windows or Linux machine. Be aware that the simulator machine and the edge device have to be in the same network to be able to communicate.

Once the simulator is up and running it sends simulated data to an MQTT broker. The application module `alm-mqtt-module` running on the device listens to the MQTT topics from the simulator. It then redirects the received messages directly to the specific demo application module `edge-demo` where the data can be handeled.
