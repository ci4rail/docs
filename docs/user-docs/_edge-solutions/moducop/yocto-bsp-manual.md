---
title: ModuCop Yocto BSP Manual
excerpt: User and developer manual for the ModuCop Yocto Board Support Package.

custom_next: /edge-solutions/moducop/general/specification/

---
This manual describes how to use the standard Yocto Linux images from Ci4Rail for the ModuCop Edge Computer MEC01.

The manual does not describe how to build the images, instead it describes how to use the pre-built images and how to adapt them to your needs. In case you want to build your own image, you can use [our yocto-images repo on github](https://github.com/ci4rail/yocto-images)

This documentation is valid for the Image versions 2.x and higher, which are based on Yocto 5.x (Scarthgap) and Linux kernel 6.6.54. *Scarthgap* is the latest [LTS version of Yocto](https://wiki.yoctoproject.org/wiki/Releases), which is supported until 2028.


## Contents

* Container runtime
* Custom adaptions
  * Setting password for root user
  * Setting hostname
  * Creating a systemd service
* BSP Functions
   * Network Interfaces
     * Ethernet
     * WiFi
     * Bluetooth
     * Cellular
   * GNSS
   * USB Host Port via M12
   * UART via M12
   * SDCard
   * RTC
   * Moducop Inventory Data
   * Ignition Shutdown
   * Scheduled Reboot
   * Time Synchronization
   * Tailscale VPN
 * Troubleshooting
