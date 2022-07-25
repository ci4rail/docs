---
title: io4edge Device Management
excerpt: Describes the Device Management Functionality Common to all io4edge Devices
last_modified_at: 2022-07-25

#custom_next: /edge-solutions/modusio/mio01/detailed-description/
---
**Notice** This chapter is work-in-process, will be completed soon. Stay tuned.
{: .notice}

All io4edge devices support Device Management over Network for
  * Device Scanning
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
* `io4edge-cli-vX.Y.Z-linux-arm64.tar.gz` or `io4edge-cli-vX.Y.Z-linux-arm.tar.gz` for Linux ARM systems

**Info**: Windows is currently not supported.
{: .notice--info}

Download the file to your personal Downloads folder.

[Get io4edge CLI](https://github.com/ci4rail/io4edge-client-go/releases){: .btn .btn--info}

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

## Device Identification

Each io4edge device has a *Device ID*, which is used to identify the device in the network, see [this section]({{ '/edge-solutions/io4edge/addressing' | relative_url }}) for details.

We recommend to set an application specific Device ID for all WLAN and Ethernet based io4edge modules, for USB based modules, this is not required, as a Device ID has been set in the factory.


{% include content/tab/start.md tabs="io4edge-cli, Device-Console" instance="1" %}
{% include content/tab/entry-start.md %}
You can change the Device ID with `io4edge-cli` if you know either the service address or the IP address of the io4edge device.

If the IP address is `192.168.0.234`, change the Device ID as follows:

```bash
$ ./io4edge-cli -i 192.168.0.234:9999 program-devid my-device-id
Device id was set to my-device-id
Restart of the device required to apply the new device id.
```

Or if you know the service address:
```bash
$ ./io4edge-cli -d S103-MIO01-b4e31793-f660-4e2e-af20-c175186b95be program-devid my-device-id
Device id was set to my-device-id
Restart of the device required to apply the new device id.
```

Or read Device ID:
```bash
$ ./io4edge-cli -i 192.168.0.234:9999 get-parameter device-id
my-device-id (TODO)
```

{% include content/tab/entry-end.md %}

{% include content/tab/entry-start.md %}
On WLAN/Ethernet io4edge devices, you can change the Device ID over the USB console:

TODO

{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}

## Firmware Management

io4edge devices support firmware identification and updates over network.

### Get Current Firmware Version

```bash
$ ./io4edge-cli -d S103-MIO01-b4e31793-f660-4e2e-af20-c175186b95be fw
Firmware name: fw_esp_mio01_default, Version 1.0.0
```

### Update Firmware

To perform a firmware update you need a *Firmware Package*, a file ending with `.fwpkg`.
A firmware package contains the firmware binary and a manifest file. The `io4edge-cli` checks if the firmware is suitable for the device before loading it.
