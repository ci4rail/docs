---
title: ModuCop Yocto BSP Manual
excerpt: User and developer manual for the ModuCop Yocto Board Support Package.

custom_next: /edge-solutions/moducop/general/specification/

---
This manual describes how to use the standard Yocto Linux images from Ci4Rail for the ModuCop Edge Computer MEC01/02.

The manual does not describe how to build the images, instead it describes how to use the pre-built images and how to adapt them to your needs. In case you want to build your own image, you can use [our yocto-images repo on github](https://github.com/ci4rail/yocto-images)

This documentation is valid for the Image versions 2.x and higher, which are based on Yocto 5.x (Scarthgap) and Linux kernel 6.6.54. *Scarthgap* is the latest [LTS version of Yocto](https://wiki.yoctoproject.org/wiki/Releases), which is supported until 2028.

## Contents

<ul>
  {% assign subpages = site.edge-solutions
    | where_exp: "p", "p.path contains 'yocto-bsp-manual/'"
    | sort: "order" %}
  {% for p in subpages %}
    <li><a href="{{ p.url }}">{{ p.title }}</a><br><small>{{ p.excerpt }}</small></li>
  {% endfor %}
</ul>

The following topics are TODO and will be added in the future:
  * UART via M12
  * SDCard
  * Moducop Inventory Data
  * Ignition Shutdown
  * Scheduled Reboot
  * Time Synchronization
  * Tailscale VPN
  * Troubleshooting
