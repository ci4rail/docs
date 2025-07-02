---
title: LEDs
excerpt: How to control the front panel LEDs of the ModuCop
order: 120
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The CPU01 of the ModuCop Edge Computer MEC01/02 features two front panel LEDs that can be controlled via GPIOs of the SoM.

The GPIOs differ between CPU01 (IMX8MM) and CPU01Plus (IMX8MP) SoMs, so the tables below show the GPIOs for both SoMs.

### LED GPIOs for CPU01 (IMX8MM)

| LED  | GPIOChip | GPIO Number |
| ---- | -------- | ----------- |
| LED2 | 4        | 26          |
| LED3 | 4        | 27          |

### LED GPIOs for CPU01Plus (IMX8MP)

| LED  | GPIOChip | GPIO Number |
| ---- | -------- | ----------- |
| LED2 | 0        | 5           |
| LED3 | 0        | 6           |

The GPIOs turn the LEDs on when set to low, and turn them off when set to high.

You may control the LEDs using the `gpioset` command line tool, which is available in the BSP. The following commands can be used to control the LEDs on the CPU01 SoM:

```bash
gpioset 4 26=0  # Turn on LED2 (CPU01)
gpioset 4 27=0  # Turn on LED3 (CPU01)
gpioset 4 26=1  # Turn off LED2 (CPU01)
gpioset 4 27=1  # Turn off LED3 (CPU01)
```
