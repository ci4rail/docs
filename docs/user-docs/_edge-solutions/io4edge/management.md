---
title: io4edge Device Management
excerpt: Describes the Device Management Functionality Common to all io4edge Devices
last_modified_at: 2022-03-21

#custom_next: /edge-solutions/modusio/mio01/detailed-description/
---

All io4edge devices support Device Management over Network for
  * Device Identification
  * Firmware Update
  * Firmware Identification
  * Inventory Data
  * Device Reboot

## io4edge-cli
Although the device management functions can be used through the API provided by the [Go client library](https://github.com/ci4rail/io4edge-client-go), the easiest way is to use the `io4edge-cli` tool.

### Download io4edge-cli

**Notice** On Moducop, the `io4edge-cli` is already installed in the Yocto image, download not required!
{: .notice}


Download the latest io4edge-cli. Select in `Assets` the appropriate version:
* `io4edge-cli-vX.Y.Z-linux-amd64.tar.gz` for Linux on standard x86 PCs
* `io4edge-cli-vX.Y.Z-linux-arm64.tar.gz` for `io4edge-cli-vX.Y.Z-linux-arm.tar.gz` for Linux ARM systems

**Info**: Windows is currently not supported.
{: .notice--info}

Download the file to your personal Downloads folder.

[Get EdgeFarm CLI](https://github.com/edgefarm/edgefarm-cli/releases){: .btn .btn--info}

#### Set PATH Variable

Open up a terminal and install the CLI to the `~/bin` directory.
```bash
$ mkdir -p ~/bin
$ tar zxf ~/Downloads/io4edge-cli-v<version>-linux-<arch>.tar.gz -C ~/bin io4edge-cli
$ echo PATH="$PATH:~/bin" >> ~/.bashrc
$ source ~/.bashrc
```

Verify that your PATH variable settings have been successfully by executing the io4edge CLI.

```bash
$ io4edge-cli version
io4edge-cli v0.1.6
```

## Managing Device Identification

Each io4edge device has a *Device ID*, which is used to identify the device in the network, see [this section]({{ '/edge-solutions/io4edge/addressing' | relative_url }}) for details.

We recommend to set an application specific Device ID for all WLAN and Ethernet based io4edge modules, for USB based modules, this is not required, as a Device ID has been set in the factory.


{% include content/tab/start.md tabs="hello, world" instance="1" %}
{% include content/tab/entry-start.md %}
This is hello entry
{% include content/tab/entry-end.md %}

{% include content/tab/entry-start.md %}
This is world entry
{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}
