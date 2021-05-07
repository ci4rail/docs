---
title: Use EdgeFarm Basic Functions
excerpt: First steps with EdgeFarm basic functions.
last_modified_at: 2021-05-06

custom_previous: /quick-start-guide/edgefarm/basic-functions/
custom_next: /quick-start-guide/edgefarm/simulator/
---

This chapter shows the basic usage of the edgefarm-cli to interact with the edgefarm services.

# Download `edgefarm-cli`

Download the latest edgefarm-cli. Select in `Assets` the appropriate version:
* `edgefarm.exe` for Windows
* `edgefarm` for Linux

[Download edgefarm-cli](https://github.com/edgefarm/edgefarm-cli/releases){: .btn .btn--info}

# Usage of `edgefarm-cli`

## Login

First login to your user using the login command

```console
$  edgefarm login                     
✔ Username: user@tenant1.com
Password:           
Login Succeeded
Logged in as: Stan Marsh
```

## List devices

List the devices registered in edgefarm DLM for your user.

```console
$ edgefarm dlm get devices
DEVICE ID                               	CONNECTION STATE
moducop0                                	Connected
```

## List runtimes

List the runtimes registered in edgefarm ALM for your user.

```console
$ edgefarm alm get runtimes
RUNTIME ID                               	CONNECTION STATE
moducop0                                	Connected
```

## Applying manifest

To apply an application manifest file use.

```console
$ edgefarm alm apply -f <manifest-file>
```
