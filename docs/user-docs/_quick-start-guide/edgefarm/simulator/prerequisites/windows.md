---
title: Prerequesits setup for Windows
excerpt: Prerequesits setup for Windows
last_modified_at: 2021-05-05

custom_previous: /quick-start-guide/edgefarm/simulator/prerequisites/
custom_next: /quick-start-guide/edgefarm/simulator/start-simulator/
---

# Setup

There are two ways to run the satisfy the prerequisits needed for the `Train Simulator`. 
Using WSL installing the Linux way or a standard Windows Installation process.

At this point you have to decide which way you want to go. Either the regular installation or with 'Windows Subsystem for Linux'.

<ul class="nav nav-tabs">
  <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#regular_installation" role="tab" >Regular</a></li>
  <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#wsl2_installation" role="tab">WSL2</a></li>
</ul>


<div class="tab-content">
<div class="tab-pane fade in active" id="regular_installation" role="tabpanel" markdown="1">

**Installing Docker Desktop**

You need to download and install Docker Desktop.

[Docker Desktop for Windows](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe){: .btn .btn--info}

For further information see the official Docker documentation on [how to install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/).
The Docker Desktop installation incldues the needed `docker-compose`.

**Installing git**

Download Git for Windows and select `64-bit Git for Windows Setup`. Follow the steps for installation.

[Download Git for Windows](https://git-scm.com/download/win){: .btn .btn--info}

</div>
<div class="tab-pane fade in" id="wsl2_installation" role="tabpanel" markdown="1">

**Installing Docker Desktop**

You need to download and install Docker Desktop.

[Docker Desktop for Windows](https://desktop.docker.com/win/stable/amd64/Docker%20Desktop%20Installer.exe){: .btn .btn--info}

For further information see the official Docker documentation on [how to install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/).
The Docker Desktop installation incldues the needed `docker-compose`.

**Installing Windows subsystem for Linux**

The benefit using WSL2 is that you are working in a Linux environment that. 
Using the WSL method it is recommended to install Ubuntu 20.04.

[WSL Documentation on how to install WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10#manual-installation-steps){: .btn .btn--info}

Once WSL2 with Ubuntu 20.04 is installed, continue with the [Linux setup instructions](/quick-start-guide/edgefarm/simulator/prerequisites/linux/).

</div>
</div> <!-- tab-content -->

# Troubleshooting

## I want to run this in a Windows VM on a Linux host

This scenario is not useful at all. Please continue with [Linux setup instructions](/quick-start-guide/edgefarm/simulator/prerequisites/linux/).
