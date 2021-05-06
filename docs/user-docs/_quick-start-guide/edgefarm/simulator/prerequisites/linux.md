---
title: Prerequesits setup for Linux
excerpt: Prerequesits setup for Linux
last_modified_at: 2021-05-05

custom_previous: /quick-start-guide/edgefarm/simulator/prerequisites/
custom_next: /quick-start-guide/edgefarm/simulator/start-simulator/
---

# Install docker

> Note: The following steps have been tested with Ubuntu 20.04 under `amd64`, but other Linux distributions and CPU architectures like Raspberry Pi with Raspbian may also work.
<!-- {: .notice--info} -->

Use the convenience script for automatic installation of Docker Community Edition.

```console
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

After the installation is finished create a group called `docker` and add your user to this group.

```console 
$ sudo groupadd docker
$ sudo usermod -aG docker ${USER}
```

Logout and log in again and test if docker is working properly or use `newgrp docker` to log in to the new group just created.

```console
$ docker run hello-world
```

# Install docker-compose

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#x86_64_repo" role="tab" >x86_64 / amd64</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#armhf_repo" role="tab">armhf</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#arm64_repo" role="tab">arm64</a></li>
</ul>

<div class="tab-content">
<div class="tab-pane fade in active" id="x86_64_repo" role="tabpanel" markdown="1">

```console
$ # download docker-compose for amd64
$ sudo curl https://github.com/linuxserver/docker-docker-compose/releases/latest/download/docker-compose-amd64 -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

</div>
<div class="tab-pane fade in" id="armhf_repo" role="tabpanel" markdown="1">

```console
$ # download docker-compose for arm64
$ sudo curl https://github.com/linuxserver/docker-docker-compose/releases/latest/download/docker-compose-arm64 -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

</div>
<div class="tab-pane fade in" id="arm64_repo" role="tabpanel" markdown="1">

```console
$ # download docker-compose for armhf
$ sudo curl https://github.com/linuxserver/docker-docker-compose/releases/latest/download/docker-compose-armhf -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

</div>
</div> <!-- tab-content -->

# Install git

```console
$ sudo apt update
$ sudo apt install git
```

# Troubleshooting

See this section for troubleshooting.

## Docker-ce setup fails

You can always install docker-ce manually following the steps for your distribution.
See [this link](https://docs.docker.com/engine/install/#supported-platforms) for further information.

## You are using Raspbian

Raspbian users must use the [convenience script](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script).

