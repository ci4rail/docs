---
title: Connecting to ModuCop's Linux Terminal
excerpt: How to get access to the Shell to configure ModuCop
last_modified_at: 2021-07-09

custom_previous: /quick-start-guide/moducop/powering/
custom_next: /quick-start-guide/moducop/connect-to-internet/
---

# Overview
In this section, you will connect your development PC with the ModuCop Linux terminal to configure basic parameters, such as the way to connect ModuCop with the Internet.

![System setup for Ethernet Connection]({{ '/user-docs/images/moducop/quick-start-guide/ConnectEthernet.svg' | relative_url }})


## Prerequisites

* ModuCop [supplied with Power]({{ '/quick-start-guide/moducop/powering' | relative_url }})
* Developer PC attached to local network.
* Network with DHCP support
* Ethernet Cable M12 X-Coded to RJ45

# Step 1: Connect ModuCop to Network

* Connect ModuCop's ETH1 interface to your local network using the Ethernet Cable M12 X-Coded to RJ45
* Ensure your ModuCop is powered

After a few seconds, the ETH1 link LED should light. It blinks when there is ethernet traffic.

# Step 2: Find Out the IP Address Assigned by DHCP

This step depends on your DHCP server.

For example, if you have an Internet router that runs the DHCP server, login into the web interface of your Internet router.

In the management interface of your DHCP server, look for a device named `moducop-cpu01` and note the IP address assigned to your ModuCop (e.g. `192.168.1.56`).

**WARNING:** In some office networks, DHCP may be configured to assign IP addresses only to known devices. If this is the case, ask your IT administrator to assign an IP address to your ModuCop. You will need the MAC address of your ModuCop, which can be found on a label on the ModuCop housing.
{: .notice--warning}

# Step 3: Connect to ModuCop Terminal

On your development PC, you need a ssh (Secure Shell) client to connect to ModuCop's Linux Terminal.

## Windows: Use PuTTY

Download PuTTY [here](https://www.putty.org/). Download the `.msi` package and install it.

Enter your ModuCop's IP address (that you have noted in the previous step). Leave the port as 22.

![Connect with putty]({{ '/user-docs/images/moducop/quick-start-guide/putty-connect.png' | relative_url }})

Click open.

The following dialog tells you that the host is not yet known.

![Connect with putty]({{ '/user-docs/images/moducop/quick-start-guide/putty-host-warn.png' | relative_url }})

Click "Yes" to accept.

```
login as: root
root@192.168.156´s password:
root@moducop-cpu01:~#
```

Enter `root` at `login as`.

Enter `cheesebread` as the password. While you entering the password, you will not see any feedback on the console. This is normal.

## Linux: Use `ssh`

If you have a Linux PC, open a terminal and open a ssh connection: (Instead of `192.168.1.56`, enter your ModuCop's IP address that you have noted in the previous step)
```bash
$ ssh root@192.168.1.56
password:
root@moducop-cpu01:~#
```
Enter `cheesebread` as the password. While you entering the password, you will not see any feedback on the console. This is normal.


# Change Password

Once you are logged in, you should change the root password to your own super-secret password:
```bash
root@moducop-cpu01:~# passwd
New password: <your-super-secret-password>
Retype new password: <your-super-secret-password>
passwd: password updated successfully
```
