---
title: git
excerpt: Instructions how to install git
last_modified_at: 2021-07-21
---
# Windows

## Pre-Condition

* Windows 10

> **Note: It is highly recommended using `Windows 10`. Other Windows versions are not guranteed to work.**
<!-- {: .notice--warning} -->

## Install

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


# Linux
## Pre-Condition

* Ubuntu 20.04

> **Note: The following steps have been tested with Ubuntu 20.04 under `amd64`, but other Linux distributions and CPU architectures like Raspberry Pi with Raspbian may also work.**
<!-- {: .notice--info} -->

## Install

```console
$ sudo apt update
$ sudo apt install git
```
