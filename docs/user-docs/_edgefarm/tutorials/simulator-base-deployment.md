---
title: Apply Simulator Base Deployment
excerpt: Apply the base deployment required as pre-condition for all simulator tutorials
last_modified_at: 2021-07-30
---

The `train simulator` base deployment is required to enable the communication between the train simulator and the demo modules, as well to enable the transmit of data to EdgeFarm.data service.

The following figure shows how the different parts of the simulation interact with each other. In this section, the docker container which are displayed in <span style="color:orange">orange boxes</span> are deployed to the devices.

![Basic `train simulator' demo architecture]({{ 'user-docs/images/edgefarm/tutorials/demo-arch.svg' | relative_url }} "Basic `train simulator` demo architecture")

The `train simulator` provides a MQTT broker from which the edge modules can receive the simulator data using the EdgeFarm Service Module `mqtt-bridge`. Edge and cloud modules can transmit data to `EdgeFarm.data` service with help of the `ads-node-module`. For inter-module communication the EdgeFarm Service Module `nats` (<span style="color:red">red boxes</span>) is used. There is no need to deploy this one as it is pre-installed on all devices.

# Pre-Conditions
To successfully walk through the next steps, please make sure, that the following actions have been performed.

* `train simulator` up and running. See the tutorial [Setting up a External Simulation Environment]({{ '/edgefarm/tutorials/setup-simulator/' | relative_url }}) for assistance.
* `EdgeFarm-cli` installed. See [install instructions]({{ '/edgefarm/reference-manual/prerequisites/edgefarm-cli/' | relative_url }}) for assistance.
* Cloned `train-simulator` repository. This is done in [Setting up a External Simulation Environment]({{ '/edgefarm/tutorials/setup-simulator/#get-the-train-simulator-up-and-running' | relative_url }}).

# Get the IP Address of Your Simulator

To be able to connect to the MQTT broker of the `train simulator`, the IP address of it is required.

On the machine that runs the simulator execute the folloing command to obtain it's IP address.
Run this command to find out all IP addresses. Your local network IP address probably starts with `192.168.x.x` or `10.0.x.x`.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#Windows" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Linux" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="Windows" role="tabpanel" markdown="1">

This is an example output. Your milage may vary.

```console
$ netsh interface ipv4 show address
Configuration for interface "Ethernet"
    DHCP enabled:                         Yes
    IP Address:                           192.168.1.22
    Subnet Prefix:                        192.168.1.0/24 (mask 255.255.255.0)
    Default Gateway:                      192.168.1.1
    Gateway Metric:                       0
    InterfaceMetric:                      25

Configuration for interface "Wi-Fi"
    DHCP enabled:                         Yes
    InterfaceMetric:                      25

Configuration for interface "Local Area Connection* 1"
    DHCP enabled:                         Yes
    InterfaceMetric:                      25

Configuration for interface "Local Area Connection* 10"
    DHCP enabled:                         Yes
    InterfaceMetric:                      25

Configuration for interface "Bluetooth Network Connection"
    DHCP enabled:                         Yes
    InterfaceMetric:                      65

Configuration for interface "Loopback Pseudo-Interface 1"
    DHCP enabled:                         No
    IP Address:                           127.0.0.1
    Subnet Prefix:                        127.0.0.0/8 (mask 255.0.0.0)
    InterfaceMetric:                      75

Configuration for interface "vEthernet (WSL)"
    DHCP enabled:                         No
    IP Address:                           172.17.7.17
    Subnet Prefix:                        172.17.7.16/28 (mask 255.255.255.240)
    InterfaceMetric:                      5000
```

From the example above the correct IP address is `192.168.1.22` for configuration `Ethernet`.

</div>
<div class="tab-pane fade in" id="Linux" role="tabpanel" markdown="1">

This is an example output. Your milage may vary.

```console
$ sudo nmcli connection show
NAME                UUID                                  TYPE       DEVICE
Wired connection 1  c64299a7-9bd2-37cc-b951-8e555b396002  ethernet   enp2s0
MyWifi              83db5b6d-944e-4d63-9830-2e6b5c8aaddb  wifi       wlp3s0
br-93e302019a83     00517c8d-10eb-48ce-bd8b-ec142f060513  bridge     br-93e302019a83
```

Select your network interface you are interested in to get the ip address.

```console
$ nmcli -g ip4.address connection show 'Wired connection 1'
192.168.1.22/24
```
From the example above the correct IP address is `192.168.1.22` for interface `enp2s0`.

</div>
</div> <!-- tab-content -->

# Modify and Apply Manifest File

A application in EdgeFarm is applied using a so called manifest file, which describes the final state of the application to be deployed. A application may consists of several modules. After transmit of the manifest to EdgeFarm.applications service, this one takes care of applying the modules to the desired devices. The deployment is performed using the EdgeFarm CLI called `edgefarm`.

First of all, find the example base deployment file `basis.example.yaml` in `train-simulator` repository in directory `basis` and make a copy:
```console
$ cd basis
$ cp basis.example.yaml basis.yaml
Successfully deployed: basis
```

Enter the IP address of your simulator machine as the value for the key `MQTT_SERVER` in the envs section (last line).
<sauce-code
  repo='edgefarm/train-simulation'
  file='basis/basis.example.yaml'
></sauce-code>

Apply the base deployment using the EdgeFarm CLI:
```console
$ edgefarm applications apply -f basis.yaml
```

The deployment status can be checked using EdgeFarm CLI:
```console
$ edgefarm a get deployments -o w -m

Tenant:         demo
Application:    basis
Creation date:  2021-07-30 08:24:42
+-------+---------------------------+-----------------+------------------+------------------+---------+
| TYPE  |          MODULES          | LABEL SELECTORS |     TARGETED     |     SUCCESS      | FAILURE |
+-------+---------------------------+-----------------+------------------+------------------+---------+
| all   | ads-node-module           |                 | demo_cloud       | demo_cloud       |         |
|       |                           |                 | moducop-gecko    | moducop-gecko    |         |
| edge  | mqtt-bridge               |                 | moducop-gecko    | moducop-gecko    |         |
+-------+---------------------------+-----------------+------------------+------------------+---------+
```

# Achievements of this SectionPermalink
OK, you have sucessfully deployed the base deployment for the `train simulator` tutorials. You also learned about how the system's components interact with each other. We are now ready to go to make use of the simulated data from `train simulator` in your edge devices. Now you can start over and deploy the actual use case application. Select a tutorial to continue:

{% include pages_table.html headline_link="Tutorial" url="/edgefarm/tutorials/" type="train simulator" %}
