---
title: Prerequesits Setup for Windows
excerpt: Prerequesits Setup for Windows
last_modified_at: 2021-05-06

custom_previous: /quick-start-guide/edgefarm/simulator/prerequisites/
custom_next: /quick-start-guide/edgefarm/simulator/start-simulator/

gallery:
  - url: /user-docs/images/edgefarm/simulator/prerequisites/docker-desktop-running.png
    image_path: /user-docs/images/edgefarm/simulator/prerequisites/docker-desktop-running.png
    alt: "Check if Docker Desktop is running"
    title: "Check if Docker Desktop is running"
---
This chapter gives guidance how to setup the prerequisites for the train simulator on Windows.

# Pre-Condition

* Windows 10

> **Note: It is highly recommended using `Windows 10`. Other Windows versions are not guranteed to work.**
<!-- {: .notice--warning} -->

# Setup for Windows
There are two possibilities to establish the prerequisites needed for the `Train Simulator`. 

Using a standard Windows Installation process or the Linux way using 'Windows Subsystem for Linux' (WSL2). At this point you have to decide which way you want to go. This depends on your personal taste. If you feel at home on Linux use WSL2, otherwise use the regular installation process.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#regular_installation" role="tab" >Regular</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#wsl2_installation" role="tab">WSL2</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane fade in active" id="regular_installation" role="tabpanel" markdown="1">

**Installing Docker Desktop**

You need to download and install Docker Desktop. Perform all reboots you are prompted.

[Get Docker Desktop for Windows](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe){: .btn .btn--info}

After the installation is finished you will be prompted to install the *Linux kernel update package*.

[Get Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi){: .btn .btn--info}

Verify that Docker Desktop is running. The status bar must be 'green'.

{% include gallery %}{: style="width: 60%"}

You are now ready to use docker. Open a `cmd.exe` and try running a basic hello world container.

```console
> docker run --rm hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete 
Digest: sha256:f2266cbfc127c960fd30e76b7c792dc23b588c0db76233517e1891a4e357d519
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
  
```

If you need further information please consult the official Docker documentation on [how to install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/).

No worries, we are almost done. Please continue with `Installing git`.

**Installing git**

Download Git for Windows and select `64-bit Git for Windows Setup`. Follow the steps for installation.

[Get Git for Windows](https://git-scm.com/download/win){: .btn .btn--info}

After installing Git for Windows open up `git-bash`.

![Starting git-bash]({{ 'user-docs/images/edgefarm/simulator/prerequisites/start-git-bash.png' | relative_url }} "Starting git-bash"){: style="width: 40%"}

After that enter the following command. This keeps the original line endings that are needed for the system to work correctly.

```console
  git config --global core.autocrlf false
```

![Configure git line endings]({{ 'user-docs/images/edgefarm/simulator/prerequisites/git-bash.png' | relative_url }} "Configure git line endings"){: style="width: 50%"}

You are now ready to use git.
</div>
<div class="tab-pane fade in" id="wsl2_installation" role="tabpanel" markdown="1">


**Installing Docker Desktop**

You need to download and install Docker Desktop. Perform all reboots you are prompted.

[Get Docker Desktop for Windows](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe){: .btn .btn--info}

After the installation is finished you will be prompted to install the *Linux kernel update package*. 

[Get Linux kernel update package](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi){: .btn .btn--info}

Verify that Docker Desktop is running. The status bar must be 'green'.

{% include gallery %}{: style="width: 60%"}

You are now ready to use docker. Try running a basic hello world container.

```console
> docker run --rm hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete 
Digest: sha256:f2266cbfc127c960fd30e76b7c792dc23b588c0db76233517e1891a4e357d519
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
1. The Docker client contacted the Docker daemon.
2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
$ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
https://hub.docker.com/

For more examples and ideas, visit:
https://docs.docker.com/get-started/
  
```

Continue with `Installing Windows subsystem for Linux`.

If you need further information please consult the official Docker documentation on [how to install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/).

**Installing Windows subsystem for Linux**

The benefit using WSL2 is that you are working in a Linux environment that. It is recommended to install Ubuntu 20.04.

There are 6 steps provided in the [official documentation on how to install WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10#manual-installation-steps).

Follow the steps 1 to 3 to enable and install WSL2.

Step 4 (`Linux kernel update package`) has been already done by following the previous instructions for installing Docker Desktop. So let's skip this.

Continue with the steps 5 and 6 to install Ubuntu 20.04.

Once WSL2 and Ubuntu 20.04 is installed, continue with the [Linux setup instructions](/quick-start-guide/edgefarm/simulator/prerequisites/linux/). Inside Ubuntu 20.04 docker and docker-compose need to be installed.
</div>
</div> <!-- tab-content -->

# Troubleshooting

## I want to run this in a Windows VM on a Linux host

This scenario is not useful at all. Please continue with [Linux setup instructions](/quick-start-guide/edgefarm/simulator/prerequisites/linux/).

## My status bar in Docker Desktop is not `green`

Please verify that you've installed the `Linux kernel update package`. Try performing a reboot.


# Achievements of this Section
Perfect, you have successfully setup all pre-conditions to run our train-simulator-demo on your machine under a Windows 10 environment. In the next sections, you will use the simulator to provide realistic train data to your edge device. 