---
title: Docker-Compose
excerpt: Instructions how to install docker-compose
last_modified_at: 2021-07-21
---

# Windows

## Pre-Condition

* Windows 10
* Docker installed (See [Install Docker]({{ '/edgefarm/reference-manual/install-docker/' | relative_url }}) for help)

> **Note: It is highly recommended using `Windows 10`. Other Windows versions are not guranteed to work.**
<!-- {: .notice--warning} -->

## Install

There are two possibilities to install and use docker-compoase on a Windows machine.

Using a standard Windows Installation process or the Linux way using ‘Windows Subsystem for Linux’ (WSL2). At this point you have to decide which way you want to go. This depends on your personal taste. If you feel at home on Linux use WSL2, otherwise use the regular installation process.

On windows, docker-compose is contained in docker installation. In case standard Windows installation is selected, there is nothing to do.

In case, WSL2 is selected, please follow the [Linux setup instructions](#linux). Inside Ubuntu 20.04 docker-compose needs to be installed as well.

# Linux
## Pre-Condition

* Ubuntu 20.04
* Docker installed (See [Install Docker]({{ '/edgefarm/reference-manual/install-docker/' | relative_url }}) for help)

> **Note: The following steps have been tested with Ubuntu 20.04 under `amd64`, but other Linux distributions and CPU architectures like Raspberry Pi with Raspbian may also work.**
<!-- {: .notice--info} -->

## Install
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
$ # download docker-compose for armhf
$ sudo curl https://github.com/linuxserver/docker-docker-compose/releases/latest/download/docker-compose-armhf -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

</div>
<div class="tab-pane fade in" id="arm64_repo" role="tabpanel" markdown="1">

```console
$ # download docker-compose for arm64
$ sudo curl https://github.com/linuxserver/docker-docker-compose/releases/latest/download/docker-compose-arm64 -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

</div>
</div> <!-- tab-content -->
