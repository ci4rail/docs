---
title: Starting the Simulator
excerpt: Starting the Simulator
last_modified_at: 2021-05-06

custom_previous: /quick-start-guide/edgefarm/simulator/prerequisites/
custom_next: /quick-start-guide/edgefarm/simulator/deploy-demo-app/
---

This describes how to get the `Train Simulator` up and running. 
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

Clone the repository `edgefarm-demos` and start the simulator using docker-compose.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#Windows" role="tab" >Windows</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#Linux" role="tab">Linux</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="Windows" role="tabpanel" markdown="1">
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
<div class="tab-pane fade in" id="Linux" role="tabpanel" markdown="1">
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

Next go to Node-Red's web UI [http://localhost:1880](http://localhost:1880) to start the simulation. Click on the blue control right next to the `start` node.

![Start the simulation]({{ 'user-docs/images/edgefarm/simulator/start-simulation.png' | relative_url }} "Start the simulation"){: style="width: 75%"}

Go to the dashoard to view the values generated in the simulation [http://localhost:1880/ui](http://localhost:1880/ui).

![Running simulation]({{ 'user-docs/images/edgefarm/simulator/simulation-running.png' | relative_url }} "Running simulation"){: style="width: 75%"}

# Testing the Simulator

To test the simulation run this command to create a new MQTT client running as a container subscribing to all topics the simulator will output.

```console {% raw %}
$ docker run -it --rm efrecon/mqtt-client sub -h `docker network inspect bridge --format='{{(index .IPAM.Config 0).Gateway}}'` -t "simulation/#" -v
{% endraw %}```

When you're done abort with `Ctrl+C`.

# Troubleshooting

## Running Windows the simulator won't start up and gives an error: "No such file or directory"

If you are running Windows, please ensure that you've set up `Git for Windows` correctly. The problem might be wrong line endings. 
Open a `git-bash` and type in `git config --global core.autocrlf false`. Then delete `edgefarm-demos` and redo the `git clone` command.