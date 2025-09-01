---
title: PC Setup
excerpt: Setting up your PC for the Lyve Demo Kit
custom_next: /lyve/lyve-demo-kit-rev-0/ip-network-setup/
---

Your PC will be used to
* Configure the Tracelet parameters
* Visualize the position of the vehicle
* Visualize quality metrics of the tracelet

![Architecture](/user-docs/images/lyve/lyve-demo-kit-rev0-pc-setup1.svg){: style="width: 50%"}

Quick explanation of the software components:
* Easyplan: A Windows app to visualize and record the vehicle tracks on a map
* Grafana: A web-based container to visualize the quality metrics of the tracelet
* Prometheus: A time-series database used to store the quality metrics of the tracelet
* redpanda-connect: A connector to stream the tracelet data to other systems. In our application, it splits the tracelet message into positioning data and quality metrics. Can be used also to publish the data to other systems, e.g. via MQTT.
* io4edge-cli: A command line tool to manage Tracelet parameters and firmware.

## Software Installation

We assume you have a Windows 11 PC. Windows 10 may work but has not been tested.

Install the following software:

1. **Docker Desktop**: Follow the [installation guide](https://docs.docker.com/desktop/setup/install/windows-install/) to install Docker Desktop on your PC. Note: Docker desktop requests a fee for larger organizations.
2. Optional: **git**: Follow the [installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to install git on your PC.

### Install the docker composition

If you have `git` installed, go to an arbitrary directory, where you want the docker composition files to be stored, e.g. `c:\work`.

```
c:
cd c:\work
git clone -b rev-0 https://github.com/ci4rail/lyve-demokit.git
cd lyve-demokit
```

If you don't have `git` installed, you can download the zip file of the repository from GitHub and extract it to your desired location. With your browser, to to `https://github.com/ci4rail/lyve-demokit`, select branch `rev-0`, then select `Code` > `Download ZIP`.

Go into the directory where you have cloned/unzipped the repository and start the docker composition with the following command:

```
docker-compose up -d
```

Check if the docker containers are running:

```
docker compose ps
```
Should show three running containers:

```
NAME                        IMAGE                                 COMMAND                  SERVICE      CREATED          STATUS                  PORTS
lyve-demokit-benthos-1      ci4rail/redpanda-connect-kyt:v1.1.0   "./redpanda-connect-…"   benthos      13 seconds ago   Up 9 seconds            0.0.0.0:4195->4195/tcp, 0.0.0.0:11001->11001/udp
lyve-demokit-grafana-1      grafana/grafana-enterprise:11.3.1     "/run.sh"                grafana      13 seconds ago   Up 9 seconds            0.0.0.0:3000->3000/tcp
lyve-demokit-prometheus-1   prom/prometheus:v2.53.5               "/bin/prometheus --c…"   prometheus   13 seconds ago   Up Less than a second   0.0.0.0:9090->9090/tcp
```

Check if grafana is running:
* Open your web browser and navigate to `http://localhost:3000`.
* Log in with the following credentials:

    * Username: lyve-demo
    * Password: lyve123

Click on Dashboards->Single Tracelet Details

![Tracelet Dashboard](/user-docs/images/lyve/lyve-grafana1.png){: style="width: 50%"}


### Install Easyplan

Easyplan is available online for download at [Pinpoint Cloud](https://connect.pinpoint.de/).
It's currently accessible only for customers of the LYVE Demo Kit. The credentials to access it will be provided by your LYVE contact.


### Install io4edge-cli to configure Tracelet

The `io4edge-cli` is a command line tool used to configure the parameters of the Tracelet.

Create a directory to store it, for example:
```
mkdir C:\work\io4edge-cli
```

Download the [Release](https://github.com/ci4rail/io4edge-client-go/releases/download/v2.0.0-alpha.5/io4edge-cli-v2.0.0-alpha.5-windows-amd64.zip) from github and store it into the folder you've created.

Unzip the `.zip` file into the same folder.

Check if you can execute it
```
C:\work\io4edge-cli\io4edge-cli.exe --help
```
