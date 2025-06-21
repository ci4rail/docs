---
title: Pre-Built Yocto Images
excerpt: Pre-Built Yocto Images for ModuCop Edge Computer

custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---
The pre-built images can be found on [github](https://github.com/ci4rail/yocto-images/releases). Within the releases there are several flavours of the image, for example `Moducop-CPU01Plus_Standard-Image_v2.3.1.4823182.20250603.1127.mender`.


The image names follow a specific naming convention to help identify the content and purpose of the images. The naming convention is as follows:

```
<CPU Type>_<Image Type>_<Version>.<Update Type>
```

Where:

* CPU Type
  * `ModuCop-CPU01` is for ModuCops with iMX8M Mini CPU.
  * `ModuCop-CPU01Plus` is for ModuCops with iMX8M Plus CPU.

* Image Type:
  * `Standard` is the standard image for the ModuCop Edge Computer.
  * `Devtools` is an image with more development tools pre-installed, useful for debugging and development purposes. It requires no root password during login.

* Update Type:
    * `*.mender` images allow to update the root filesystem via the Mender OTA update system. This is the recommended way to update the rootfs to a newer version without touching your custom configurations.
    * `*.mender_tezi.tar` files are intended for factory programming of the device, replacing all existing content on the device.
