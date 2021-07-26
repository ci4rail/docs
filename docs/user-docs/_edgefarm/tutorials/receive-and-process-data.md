---
title: Receive and Process MQTT Data
excerpt: Simple example of receiving MQTT data from an external device and transferring the data to the cloud using the train simulator
last_modified_at: 2021-07-26
---
The Train Simulator Demo application for this use-case is a component that runs on the edge device. You are going to deploy an demo application on the edge device to read the data received from the `Train simulator` and handle them. To keep it simple, our demo application provides a simple dump of the received data. Of course you are free to apply any data handling in a custom application.

# Pre-Conditions

To successfully walk through the next steps, please make sure, that the following actions have been performed.

* `Train simulator` up and running. See the tutorial [Setting up a External Simulation Environment](/edgefarm/tutorials/setup-simulator/) for assistance.
* `EdgeFarm-cli` installed. See [this](/edgefarm/reference-manual/prerequisites/edgefarm-cli/) for assistance.
* Cloned `edgefarm-demos` repository. This is done in [Setting up a External Simulation Environment](/edgefarm/tutorials/setup-simulator/#get-the-train-simulator-up-and-running)).
* Terminal connection to ModuCop. See [Connecting to ModuCop’s Linux Terminal](/edge-solutions/moducop/quick-start-guide/connect-to-terminal/) for assistance.

# Get the IP Address of Your Simulator

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

```
$ nmcli -g ip4.address connection show 'Wired connection 1'
192.168.1.22/24
```
From the example above the correct IP address is `192.168.1.22` for interface `enp2s0`.

</div>
</div> <!-- tab-content -->

# Connect Simulator Output to Edge Device

In order to connect the simulated data now to the edge device, we are going to apply an updated manifest file which will take care of deploying our demo application to the edge computer. The deployment is performed using the EdgeFarm CLI called `edgefarm`. This quick-start-guide assumes that the CLI is used on the same machine as the simulator is running.

## Modify Manifest File
First of all, please modify the manifest.yaml found in directory `edgefarm-demos/train-simulation/edge`. This is neccessary to establish communication between the application running on the edge device and the machine that runs the simulation.

Enter the IP address of your simulator machine as the value for the key `MQTT_SERVER` in the envs section (line 11).

This example shows how this might look like:

{% highlight yaml linenos %}
application: train-simulator
modules:
  - name: alm-mqtt-module
    image: harbor.ci4rail.com/edgefarm/alm-mqtt-module:0.1.0-22.Branch.main.Sha.08e21b9e732fe725a4722302bf0c46e27afa76cc
    createOptions: '{}'
    imagePullPolicy: on-create
    restartPolicy: always
    status: running
    startupOrder: 1
    envs:
      MQTT_SERVER: 192.168.1.22:1883
  - name: edge-demo
    image:  harbor.ci4rail.com/edgefarm/train-simulator-edge-demo:0.1.0-11.Branch.main.Sha.80849351b5dedfb10f4c894c2cf4e471d16e0708
    createOptions: '{}'
    imagePullPolicy: on-create
    restartPolicy: always
    status: running
    startupOrder: 1
{% endhighlight %}

## Deploy the Application Manifest

Apply the application manifest by the corresponding EdgeFarm command.

```console
$ edgefarm alm apply -f manifest.yaml
```

Now wait for the containers get deployed.
Open the terminal connection to the edge device. You can monitor the status of the deployment by triggering `docker ps` manually and looking for containers called `train-simulator_alm-mqtt-module` and `train-simulator_edge-demo`.
Once the deployment is done the output should look similar to this.

```console
$ docker ps
CONTAINER ID  IMAGE                                                                                                                     COMMAND                 CREATED         STATUS         PORTS                                                                 NAMES
98b628acf96b  harbor.ci4rail.com/edgefarm/train-simulator-edge-demo:0.1.0-11.Branch.main.Sha.80849351b5dedfb10f4c894c2cf4e471d16e0708   "python3 -u ./main.py"  10 seconds ago  Up 10 seconds                                                                        train-simulator_edge-demo
f51de4aa3a12  harbor.ci4rail.com/edgefarm/alm-mqtt-module:0.1.0-22.Branch.main.Sha.08e21b9e732fe725a4722302bf0c46e27afa76cc             "/alm-mqtt-module"      10 seconds ago  Up 10 seconds                                                                        train-simulator_alm-mqtt-module
3662738bc98d  nats:2.1.9-alpine                                                                                                         "docker-entrypoint.s…"  2 weeks ago     Up 2 weeks     4222/tcp, 6222/tcp, 8222/tcp                                          nats
2de416b8763f  mcr.microsoft.com/azureiotedge-hub:1.0                                                                                    "/bin/sh -c 'echo \"…"  2 weeks ago     Up 2 weeks     0.0.0.0:443->443/tcp, 0.0.0.0:5671->5671/tcp, 0.0.0.0:8883->8883/tcp  edgeHub
21f31abc9bf0  mcr.microsoft.com/azureiotedge-agent:1.0                                                                                  "/bin/sh -c 'exec /a…"  2 weeks ago     Up 2 weeks                                                                           edgeAgent
```


# Verify the Train Simulator Data on Your Device

To verify that everything is properly connected and running, view the logs of the `train-simulator_edge-demo` container by running `docker logs train-simulator_edge-demo -f`. The output should look similar to this.

```console
$ docker logs train-simulator_edge-demo -f
{'device': 'moducop0', 'acqTime': 1620300886, 'payload': b'{"sensorname":"temperature","timestamp":1620300886,"value":"31.57"}'}
{'device': 'moducop0', 'acqTime': 1620300887, 'payload': b'{"sensorname":"temperature","timestamp":1620300887,"value":"30.91"}'}
{'device': 'moducop0', 'acqTime': 1620300888, 'payload': b'{"sensorname":"temperature","timestamp":1620300888,"value":"30.30"}'}
{'device': 'moducop0', 'acqTime': 1620300889, 'payload': b'{"sensorname":"temperature","timestamp":1620300889,"value":"29.75"}'}
```

When you are done abort with `Ctrl+C`.


# Achievements of this Section
Congratulations! You just finished your first application deployment using the EdgeFarm CLI!
You also learned about how to setup the train simulator and how the system's components interact with each other.
