---
title: Mender Integration
excerpt: Using Mender for OTA updates and remote management of the ModuCop.
order: 30
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The ModuCop Yocto BSP integrates with [Mender](https://mender.io/), a popular open-source solution for over-the-air (OTA) updates and remote management of embedded devices. Mender provides a robust framework for deploying software updates, managing device configurations, and perform troubleshooting tasks remotely.

With Mender, you can:
- **Perform OTA updates**: Seamlessly update the root filesystem and applications on the ModuCop without requiring physical access to the device.
- **Execute a Remote Shell**: Access the device's shell remotely for troubleshooting and management tasks.

## Default Mender Instance
By default, the image points to mender instance owned by Ci4Rail. This allows Ci4Rail to help you with troubleshooting and support. The Mender instance is pre-configured to work with the ModuCop, so you can start using it right away without any additional setup.

## Using your own Mender instance
If you want to use your own Mender instance, create an instance in the [Mender Portal](https://mender.io/). Then you can change the configuration in the `/etc/mender/mender.conf` file. Just enter your mender `TenantToken` of your instance.

## Disabling Mender online service
If you don't want to use Mender, you can disable it by removing the `/etc/mender/mender.conf` file. This will disable the Mender client and prevent it from running on the device.

## Remote Management with Mender

This chapter assumes that you have created your instance in the Mender Portal and have the `TenantToken` entered in the `/etc/mender/mender.conf` file.

### Accept your Device in Mender Portal
To use Mender, you need to accept your device in the Mender Portal. When the device connects to the Mender server for the first time, it will appear in the Mender Portal under "Pending Devices". You need to accept the device authorization request to allow it to receive updates and remote commands.

### Rootfs OTA Updates
To perform rootfs OTA updates, you must first upload the new rootfs image to the Mender Portal.

First get the image with the `*.mender` extension from our [Releases]({{ '/edge-solutions/moducop/yocto-bsp-manual/images' | relative_url }}) and store it on your local machine.

In the mender portal navigate to the "Releases" section and upload the new image file.

Once the image is uploaded, you can create a deployment to push the update to your devices. For a single, device deployment, you can select the device from the "Devices" section and click on "Create a deployment for this device" und "Device actions".

When the device polls the Mender server, it will receive the update and apply it to the currently inactive rootfs partition. The device will reboot from the updated rootfs partition.

This update will affect only the rootfs partition, leaving your custom configurations in the data partition intact.

### Remote Shell
To access the device's shell remotely, you can use the Mender Portal's "Remote terminal" feature. Select the device, click on "Troubleshooting" and the "CONNECT TERMINAL" button. This will open a terminal session to the device, allowing you to execute commands and perform troubleshooting tasks.

You can customize the remote terminal behavior by modifying the `/etc/mender/mender-connect.conf` file. For example, you can change the default shell.
{: .notice--info}

## Offline Mode
Even without a mender instance, you can still perform rootfs updates using the Mender client. However, you must transfer the new rootfs image to the device manually, for example via SCP.

Once your image is on the device, you can use the Mender client to install the update. Run the following command as root:

```bash
mender-update install /path/to/your/image.mender
```

Then reboot the device

```bash
reboot
```

After the reboot, commit the update to make it permanent:

```bash
mender-update commit
```
