---
title: Concepts
excerpt: Concepts of the ModuCop Yocto BSP
order: 10
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

The ModuCop Yocto BSP is based on the following core concepts:

* Applications should run in ***containers***, which are managed by the container runtime.
* The root filesystem is read-only and can be updated via ***OTA updates***.
* All custom configurations are stored in a separate ***data partition***, which is writable.

## Applications in Containers

The ModuCop Yocto BSP uses a container runtime to run applications in isolated environments. This allows for easy deployment, scaling, and management of applications. The container runtime is based on [PodMan](https://podman.io/),
a lightweight and secure container engine that is compatible with Docker. PodMan allows you to run containers without requiring a daemon, making it more secure and easier to use in embedded environments. It supports the OCI (Open Container Initiative) standard for container images, so you can use any OCI-compliant container image, for example Docker images.

You can also use compose files to define multi-container applications, similar to Docker Compose. This allows you to define the services, networks, and volumes required for your application in a single file.

PodMan is widely compatible with Docker, there is even an alias `docker` for the `podman` command, so you can use it as a drop-in replacement for Docker. This means you can use existing Docker images and workflows with PodMan without any changes.

You can also run `docker compose`, which calls `podman-compose` under the hood, to manage multi-container applications. This allows you to use the same commands and workflows you are used to with Docker Compose.

All container images and volumes are stored in the data partition, which is writable. This allows you to install and update applications without modifying the root filesystem. The root filesystem remains read-only, ensuring that the system is secure and stable.

TODO: Add examples

## Disk Partitioning

ModuCop uses a specific disk partitioning scheme to separate the root filesystem from the data partition. This allows for easy updates and custom configurations without affecting the core system.
The disk is partitioned into the following partitions:

* **Boot Partition**: Contains the `boot.scr` boot script, which is executed by u-boot during the boot process.
* **Root Partition A** and **Root Partition B**: Contains the root filesystem, which is read-only and can be updated via OTA updates. Only one of the two roofs partitions is active at a time, the other one is used for updates. After the update, the system will boot from the updated root partition. This allows for seamless updates without significant downtime.

* **Data Partition**: Contains all custom configurations, container images, and volumes. This partition is writable and allows you to store your custom data without affecting the root filesystem.


## Rootfs Overlays

The ModuCop Yocto BSP uses rootfs overlays to allow for custom configurations and modifications to the root filesystem without modifying the original files. This is done by creating overlay directories in the data partition and tempfs filesaystem, which contains the custom files and directories that should override the original files in the root filesystem.

When the system boots, the overlay directory is mounted on top of the root filesystem, allowing you to access and modify the files in the overlay directory as if they were part of the root filesystem. This allows you to customize the system without modifying the original files, making it easier to update the root filesystem without losing your custom configurations.

The following directories are overlayed by default:

| Directory    | Description                                    | Destination    |
| ------------ | ---------------------------------------------- | -------------- |
| `/etc`       | Contains system configuration files.           | data partition |
| `/root`      | Contains the home directory for the root user. | data partition |
| `/var/cache` |                                                | tmpfs         |
| `/var/lib`   |                                                | tmpfs         |
| `/var/spool` |                                                | tmpfs         |

Furthermore, some directories are temporary and are mounted as `tmpfs` to avoid writing to the flash memory:

| Directory       | Description                                                   | Destination |
| --------------- | ------------------------------------------------------------- | ----------- |
| `/var/volatile` | Contains volatile data that is not persistent across reboots. | tmpfs       |
| `/var/run`      | Contains runtime data that is not persistent across reboots.  | tmpfs       |

`/var/log` is a symlink to `/var/volatile/log`, which is also a `tmpfs` mount.
