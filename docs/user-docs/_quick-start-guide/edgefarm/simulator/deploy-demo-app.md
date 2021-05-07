---
title: Deploying the demo application
excerpt: Deploying the demo application
last_modified_at: 2021-05-06

custom_previous: /quick-start-guide/edgefarm/simulator/start-simulator/
---
The Train Simulator Demo application is the part thar runs on the ModuCop.

# Prerequisites

* `Train simulator` up and running. See the [previous section](/quick-start-guide/edgefarm/simulator/start-simulator/) for assistance.
* `edgefarm-cli` installed. See [Using Basic Functions](/quick-start-guide/edgefarm/basic-functions/) for assistance.
* Cloned `edgefarm-demos` repository. This is done in the [Starting the Train Simulator](/quick-start-guide/edgefarm/simulator/start-simulator/) section.
* Terminal connection to ModuCop. See [Connecting to ModuCop’s Linux Terminal](/quick-start-guide/moducop/connect-to-terminal/) for assistance.

# Getting the IP Address of your simulator

On the machine that runs the simulator run the folloing command to obtain its IP address.
Run this command to find out all IP addresses. Your local network IP address probably starts with `192.168.x.x` or `10.0.x.x`.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#Windows" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Linux" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="Windows" role="tabpanel" markdown="1">

```console
$ netsh interface ipv4 show address
```

</div>
<div class="tab-pane fade in" id="Linux" role="tabpanel" markdown="1">

```console
$ hostname -I 
```

</div>
</div> <!-- tab-content -->

# Modifying the application manifest

The deployment is performed using the `edgefarm` cli. This quick-start-guide assumes that the CLI is used on the same machine as the simulator is running.

Modify the manifest.yaml found in directory `edgefarm-demos/train-simulation/edge`.
Enter the IP address of your simulator machine as the value for the key `MQTT_SERVER` in the envs section.

This example shows how this might look like:

```yaml
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
      MQTT_SERVER: 192.168.24.14:1883
  - name: edge-demo
    image:  harbor.ci4rail.com/edgefarm/train-simulator-edge-demo:0.1.0-11.Branch.main.Sha.80849351b5dedfb10f4c894c2cf4e471d16e0708
    createOptions: '{}'
    imagePullPolicy: on-create
    restartPolicy: always
    status: running
    startupOrder: 1
```

# Deploying the application manifest

Apply the application manifest 

```console
$ edgefarm alm apply -f manifest.yaml
```

Now wait for the containers get deployed.
Open the terminal connection to the ModuCop. You can monitor the status of the deployment by triggering `docker ps` manually and looking for containers called `train-simulator_alm-mqtt-module` and `train-simulator_edge-demo`.
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

# Testing the train simulator on the device

View the logs of the `train-simulator_edge-demo -f` container by running `docker logs`. The output should look similar to this.

```console
$ docker logs train-simulator_edge-demo
{'device': 'moducop0', 'acqTime': 1620300886, 'payload': b'{"sensorname":"temperature","timestamp":1620300886,"value":"31.57"}'}
{'device': 'moducop0', 'acqTime': 1620300887, 'payload': b'{"sensorname":"temperature","timestamp":1620300887,"value":"30.91"}'}
{'device': 'moducop0', 'acqTime': 1620300888, 'payload': b'{"sensorname":"temperature","timestamp":1620300888,"value":"30.30"}'}
{'device': 'moducop0', 'acqTime': 1620300889, 'payload': b'{"sensorname":"temperature","timestamp":1620300889,"value":"29.75"}'}
```

When you are done abort with `Ctrl+C`.

# Final words

Congratulations! You just finished your first application deployment using the edgefarm cli!
You also learned about how to setup the train simulator and how the systems components interact with each other.
