---
title: Accelerometer
excerpt: How to use the Accelerometer of the ModuCop Edge Computer

product_name: CPU01UC
example_device_name: S101-CPU01UC
order: 100
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

ModuCop features an integrated accelerometer, which is a LIS2DW12 3-axis accelerometer. It is implemented on the CPU01 microcontroller (CPU01UC).

{% include content/io4edge/lis2d-motionsensor/detailed-description.md %}

### Orientation of the Accelerometer in ModuCop

The orientation of the accelerometer in the ModuCop Edge Computer is fixed and cannot be changed. The X, Y, and Z axes are defined as follows:

![Accelerometer Orientation]({{ '/user-docs/images/edge-solutions/moducop/cpu01-accelerometer.drawio.svg' | relative_url }})
