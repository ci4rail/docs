---
title: Start the Simulator
excerpt: Start the Simulator
last_modified_at: 2021-07-09

custom_previous: /quick-start-guide/edgefarm/simulator/prerequisites/
custom_next: /quick-start-guide/edgefarm/simulator/deploy-demo-app/
---

As mentioned in previous sections, the simulator creates realistic train data and provides it to your edge device. This section helps you to get the `Train Simulator` up and running.


The steps are:
1. Getting the simulator using git
2. Starting the simulator environment using docker-compose
3. Starting the simulation itself
4. Testing if the simulator works properly

# Prerequisites

The following tools must be installed. See the [previous section](/quick-start-guide/edgefarm/simulator/prerequisites/) for assistance.

* docker
* docker-compose
* git


# Get the Train Simulator up and Running

Clone the `edgefarm-demos` repository and start the simulator with docker-compose. The simulator can be seen as a logical group of two services:
* Node-Red to generate the simulated data.
* Mosquitto as the MQTT broker for distributing this data.

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
> git clone https://github.com/edgefarm/edgefarm-demos.git
> cd edgefarm-demos\train-simulation\simulator
> docker compose up -d
 WARNING: The UID variable is not set. Defaulting to a blank string.
 WARNING: The GID variable is not set. Defaulting to a blank string.
 Creating network "simulator_edgefarm-simulator" with the default driver
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
$ git clone https://github.com/edgefarm/edgefarm-demos.git
$ cd edgefarm-demos/train-simulation/simulator/
$ docker-compose up -d
Creating network "simulator_edgefarm-simulator" with the default driver
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

# Start the simulator using Node-Red
Please access the Node-Red's web UI [http://localhost:1880](http://localhost:1880) and start the simulation by clicking on the blue control right next to the `start` node.

![Start the simulation]({{ 'user-docs/images/edgefarm/simulator/start-simulation.png' | relative_url }} "Start the simulation"){: style="width: 75%"}

You can view the generated data by visiting the dashoard [http://localhost:1880/ui](http://localhost:1880/ui).

![Running simulation]({{ 'user-docs/images/edgefarm/simulator/simulation-running.png' | relative_url }} "Running simulation"){: style="width: 75%"}

The simulation is now up and running but there is not yet any consumer of those data. Let's establish that in the next step.

# Connect to Simulator

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
> docker run -it --rm efrecon/mqtt-client sub -h 172.17.0.1 -t "simulation/#" -v
simulation/temperature {"sensorname":"temperature","timestamp":1620620201,"value":"0.39"}
simulation/temperature {"sensorname":"temperature","timestamp":1620620202,"value":"1.15"}{% endraw %}
```
</div>
<div class="tab-pane fade in" id="LinuxId2" role="tabpanel" markdown="1">
```console{% raw %}
$ docker run -it --rm efrecon/mqtt-client sub -h `docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'` -t "simulation/#" -v
simulation/temperature {"sensorname":"temperature","timestamp":1620620201,"value":"0.39"}
simulation/temperature {"sensorname":"temperature","timestamp":1620620202,"value":"1.15"}{% endraw %}
```
</div>
</div> <!-- tab-content -->

When you're done abort with `Ctrl+C`.

# Troubleshooting

## Running Windows the simulator won't start up and gives an error: "No such file or directory"

If you are running Windows, please ensure that you've set up `Git for Windows` correctly. The problem might be wrong line endings.
Open a `git-bash` and type in `git config --global core.autocrlf false`. Then delete `edgefarm-demos` and redo the `git clone` command.


# Achievements of this Section
OK, you have setup and started the simulator, it's ceating train data. In addition, you have connected the simulator output to an MQTT client. We are now ready to go to make use of those simulated data in your edge devices.
