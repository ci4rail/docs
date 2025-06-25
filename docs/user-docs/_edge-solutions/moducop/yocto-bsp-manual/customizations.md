---
title: Customizations
excerpt: How to add customizations to the ModuCop Yocto BSP
order: 50
custom_previous: /edge-solutions/moducop/yocto-bsp-manual/partition-concept/
custom_next: /edge-solutions/moducop/yocto-bsp-manual/rootfs-ota-update/
---

Because the root filesystem is read-only, you cannot modify it directly. Instead, you can use the writable data partition to store your custom configurations and modifications. This allows you to keep the root filesystem clean and stable while still being able to customize the system to your needs.

For examples, you can create systemd service files in `/etc/` because this directory is overlayed by the data partition.

The following lists some common customizations you can make:

## Changing the root password

To change the root password, you can use the `passwd` command. This will update the password in the data partition, so it will persist across reboots.

```bash
echo "root:mynewpassword" | chpasswd
```

## Changing the hostname

By default, the hostname is set to `MEC0[12]-<first-part-ofserial number>`. You can change it like this:

```bash
hostnamectl set-hostname MyNewHostname
```

## Changing the network configuration

Most network interfaces (Ethernet, Wifi and Cellular) are configured via NetworkManager. You can use the `nmcli` command to manage network connections.

To list all available connections, you can run:

```bash
nmcli -t c
```

For example, to set a static IP address for a specific interface, you can run:

```bash
nmcli con mod <connection-name> ipv4.addresses <ip-address>/<subnet-mask>
nmcli con mod <connection-name> ipv4.gateway <gateway-ip>
nmcli con mod <connection-name> ipv4.dns <dns-ip>
nmcli con mod <connection-name> ipv4.method manual
nmcli con up <connection-name>
```

This will change the settings in `/etc/NetworkManager/system-connections/<connection-name>.connection`.

## Adding custom systemd services

You may want to add custom systemd services to run your applications or scripts at boot time. You can create a service file in the `/etc/systemd/system/` directory, which is overlayed by the data partition.

Simple example:

Create a file `/etc/systemd/system/hello.service` with the following content:

```ini
[Unit]
Description=Create /tmp/hello.txt with 'hello'

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo "hello" > /tmp/hello.txt'
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
```

Then enable the service to run at boot:

```bash
systemctl enable hello.service
```

After the next reboot, you should find a file `/tmp/hello.txt` with the content `hello`.
