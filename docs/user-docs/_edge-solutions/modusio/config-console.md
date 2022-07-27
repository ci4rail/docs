---
title: Connect ModuSio Service Interface to a Computer
excerpt: Connect ModuSio Service Interface to a Computer.
last_modified_at: 2022-07-27
---
Connect the `SERVICE` interface to a computer using a USB cable.

{% include content/tab/start.md tabs="Windows, Linux" instance="terminal" %}
{% include content/tab/entry-start.md %}

Find out the COM port number by starting the Windows Device Manager, check for Serial Device `Silicon Labs CP210x`:

![Check Device Manager]({{ '/user-docs/images/edge-solutions/modusio/devicemanager-modusio-serial.png' | relative_url }}){: style="width: 25%"}

Start a terminal program on the computer and connect it with the virtual COM port. The following examples are shown for [`putty`](https://www.putty.org/):

![Start Putty]({{ '/user-docs/images/edge-solutions/modusio/putty-modusio-serial.png' | relative_url }}){: style="width: 25%"}

Enter the COM port number from the Windows Device Manager in `Serial Line`, set `Speed` to `115200` and press `Open`:

{% include content/tab/entry-end.md %}
{% include content/tab/entry-start.md %}

TODO

{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}
