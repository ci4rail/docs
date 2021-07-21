---
title: Setting up a External Simulation Environment
excerpt: Setup the Train-Simulator
last_modified_at: 2021-07-21
---

The `Train Simulator` has been designed to experience the complete data chain from simulation of realistic train data, acquisition in the edge device, transfer to cloud and both visualization in dashboards and export to external data systems. The simulated data vary from simple diagnosis data via train network messages to high frequent measurement data.

With this demonstrator, you will get an impression how EdgeFarm components work and how they interact.

The following image shows how the different parts of the simulation interact with each other.

![Basic Train Simulator Demo architecture]({{ 'user-docs/images/edgefarm/simulator/demo-arch.svg' | relative_url }} "Basic Train Simulator Demo architecture"){: style="width: 50%"}

While the data acquistion and pre-processing will be executed on the edge device, the simulator has to be setup on a Windows or Linux machine. Be aware that the simulator machine and the edge device have to be in the same network to be able to communicate.

Once the simulator is up and running it sends simulated data to an MQTT broker. The application module `alm-mqtt-module` running on the device listens to the MQTT topics from the simulator. It then redirects the received messages directly to a specific demo application module where the data can be handeled.

The steps are:
1. Installing prerequisites
2. Getting the simulator using git
3. Starting the simulator environment using docker-compose
4. Starting the simulation itself
5. Testing if the simulator works properly

# Pre-Condtions

In order to run the `Train Simulator` you have to establish some prerequisites on the machine that acutally runs the simulator.

The simulator runs as Docker containers. Therefore, a Docker environment must be set up beforehand. The files from the simulatior are directly cloned from our Github repository. Thefore, git needs to be installed.

If you already have the following tools up and running you can skip this section and continue directly with next section.

The tools needed are:

* [git]({{ '/edgefarm/reference-manual/prerequisites/git' | relative_url }})
* [docker]({{ '/edgefarm/reference-manual/prerequisites/docker' | relative_url }})
* [docker-compose]({{ '/edgefarm/reference-manual/prerequisites/docker-compose' | relative_url }})

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
