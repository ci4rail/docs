---
title: Setting up a External Simulation Environment
excerpt: Simulate a train to provide data to the edge device without the need of real sensors
last_modified_at: 2021-07-30
---

The `train simulator` has been designed to experience the complete data chain from the simulation of realistic train data, the acquisition in the edge device, the further processing in the cloud, transmission to the EdgeFarm.data service and the visualization in dashboards. The simulated data vary from simple diagnostic data via train network messages to high-frequency measurement data.

With this demonstrator, you will get an impression how EdgeFarm components work and how they interact.

The following image shows how the different parts of the simulation interact with each other. This section handles the setup of the yellow box `train simulator`.

![Basic `train simulator` Demo architecture]({{ 'user-docs/images/edgefarm/tutorials/demo-arch.svg' | relative_url }} "Basic `train simulator' Demo architecture")

While the data acquistion and pre-processing will be executed on the edge device, the simulator has to be setup on a Windows or Linux machine. Be aware that the simulator machine and the edge device have to be in the same network to be able to communicate.

Once the simulator is up and running it sends simulated data to an MQTT broker. The application module `mqtt-bridge` running on the device listens to the MQTT topics from the simulator. It then redirects the received messages directly to a specific demo application module where the data can be handeled. The edge and cloud modules may transmit data to the `EdgeFarm.data` service, which can be viewed in an Grafana Dashboard afterwards.

The steps are:
- [Installing Pre-Condtions](#installing-pre-condtions)
- [Get the `train simulator` up and Running](#get-the-train-simulator-up-and-running)
- [View the Dashboard and Webinterface of the Simulator](#view-the-dashboard-and-webinterface-of-the-simulator)
- [Testing if the Simulator Works Properly](#testing-if-the-simulator-works-properly)


# Installing Pre-Condtions

In order to run the `train simulator` you have to establish some prerequisites on the machine that acutally runs the simulator.

The simulator runs as Docker containers. Therefore, a Docker environment must be set up beforehand. The files from the simulatior are directly cloned from our Github repository. Thefore, git needs to be installed.

If you already have the following tools up and running you can skip this section and continue directly with next section.

The tools needed are:

* [git]({{ '/edgefarm/reference-manual/prerequisites/git' | relative_url }})
* [docker]({{ '/edgefarm/reference-manual/prerequisites/docker' | relative_url }})
* [docker-compose]({{ '/edgefarm/reference-manual/prerequisites/docker-compose' | relative_url }})

# Get the `train simulator` up and Running

Clone the `train-simulator` repository and start the simulator with docker-compose. The simulator can be seen as a logical group of two services:
* Node-Red to generate the simulated data
* Mosquitto as the MQTT broker for distributing this data

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#WindowsId1" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#LinuxId1" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="WindowsId1" role="tabpanel" markdown="1">
Make sure that Docker Desktop is running.
Open a command shell by pressing `Windows+R` and entering `cmd`.
Run the following commands to download and start the simulator service.
```console
> git clone https://github.com/edgefarm/train-simulation.git
> cd train-simulator\simulator\
> docker compose up -d
 WARNING: The UID variable is not set. Defaulting to a blank string.
 WARNING: The GID variable is not set. Defaulting to a blank string.
 Creating mosquitto            ... done
 Creating simulator_node-red_1 ... done
```

Verify that the simulator is up and running.

```console{% raw %}
> docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
CONTAINER ID   NAMES                                  STATUS
f204253935ce   simulator_node-red_1                   Up 3 minutes (healthy)
27f23408f865   mosquitto                              Up 3 minutes{% endraw %}
```
</div>
<div class="tab-pane fade in" id="LinuxId1" role="tabpanel" markdown="1">
Open a terminal and run the following commands to download and start the simulator service.

```console
$ git clone https://github.com/edgefarm/train-simulation.git
$ cd train-simulator/simulator/
$ docker-compose up -d
Creating mosquitto            ... done
Creating simulator_node-red_1 ... done
```

Verify that the simulator is up and running.

```console{% raw %}
$ docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
CONTAINER ID   NAMES                                  STATUS
f204253935ce   simulator_node-red_1                   Up 3 minutes (healthy)
27f23408f865   mosquitto                              Up 3 minutes{% endraw %}
```
</div>
</div> <!-- tab-content -->

# View the Dashboard and Webinterface of the Simulator

The simulated data is visually displayed in the Node-Red Dashboard. It can be viewed by visiting [http://localhost:1880/ui](http://localhost:1880/ui). Some simulations may need to be started here.

![Dashboard Home]({{ 'user-docs/images/edgefarm/tutorials/dashboard-home.png' | relative_url }} "Dashboard Home"){: style="width: 75%"}

The Node-Red's web UI, which shows the implementation behind the simulator, can be accessed by opening [http://localhost:1880](http://localhost:1880) in the browser.

![Node Red UI]({{ 'user-docs/images/edgefarm/tutorials/node-red-ui.png' | relative_url }} "Node Red UI"){: style="width: 75%"}

# Testing if the Simulator Works Properly

To test whether clients can connect to the simulator and retrieve these simulated values, run the following commands. This creates a new MQTT client that runs as a container and subscribes to all the topics that the simulator outputs.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#WindowsId2" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#LinuxId2" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="WindowsId2" role="tabpanel" markdown="1">
Find out the IP address that Docker Deskop uses on your computer. Then use this IP address to connect to the MQTT client to test the simulation. For a default installation, this IP address is `172.17.0.1`.

```console{% raw %}
> docker network inspect bridge --format="{{(index .IPAM.Config 0).Gateway}}"
172.17.0.1
> docker run -it --rm efrecon/mqtt-client sub -h 172.17.0.1 -t "#" -v
environment/temperature {"sensorname":"temperature","timestamp":1627540879,"value":"47.90"}
environment/temperature {"sensorname":"temperature","timestamp":1627540880,"value":"48.34"}
environment/temperature {"sensorname":"temperature","timestamp":1627540881,"value":"48.79"}
environment/temperature {"sensorname":"temperature","timestamp":1627540882,"value":"49.23"}
environment/temperature {"sensorname":"temperature","timestamp":1627540883,"value":"49.67"}
environment/temperature {"sensorname":"temperature","timestamp":1627540884,"value":"50.10"}
environment/temperature {"sensorname":"temperature","timestamp":1627540885,"value":"50.48"}
environment/temperature {"sensorname":"temperature","timestamp":1627540886,"value":"50.80"}
pis/req/seatRes ICE 1{% endraw %}
```
</div>
<div class="tab-pane fade in" id="LinuxId2" role="tabpanel" markdown="1">
```console{% raw %}
$ docker run -it --rm efrecon/mqtt-client sub -h `docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'` -t "#" -v
environment/temperature {"sensorname":"temperature","timestamp":1627540879,"value":"47.90"}
environment/temperature {"sensorname":"temperature","timestamp":1627540880,"value":"48.34"}
environment/temperature {"sensorname":"temperature","timestamp":1627540881,"value":"48.79"}
environment/temperature {"sensorname":"temperature","timestamp":1627540882,"value":"49.23"}
environment/temperature {"sensorname":"temperature","timestamp":1627540883,"value":"49.67"}
environment/temperature {"sensorname":"temperature","timestamp":1627540884,"value":"50.10"}
environment/temperature {"sensorname":"temperature","timestamp":1627540885,"value":"50.48"}
environment/temperature {"sensorname":"temperature","timestamp":1627540886,"value":"50.80"}
pis/req/seatRes ICE 1{% endraw %}
```
</div>
</div> <!-- tab-content -->

When you're done abort with `Ctrl+C`.

<!-- omit in toc -->
# Troubleshooting
<!-- omit in toc -->
## Running Windows the simulator won't start up and gives an error: "No such file or directory"

If you are running Windows, please ensure that you've set up `Git for Windows` correctly. The problem might be wrong line endings.
Open a `git-bash` and type in `git config --global core.autocrlf false`. Then delete `train-simulator` and redo the `git clone` command.

<!-- omit in toc -->
# Achievements of this Section
OK, you have setup and started the simulator, it's creating train data. In addition, you have connected the simulator output to an MQTT client. We are now ready to receive the simulated data in your edge devices. Therfor the next step is to [apply the base deployment]({{ '/edgefarm/tutorials/simulator-base-deployment' | relative_url }}) required for all `train simulator` tutorials.
