## Serial Port Demo

In this demo, we'll demonstrate how to connect an application on a Linux host with a {{ page.product_name }} COM port. We'll use a cable to loop the RS232 transmit pin to the receive pin, so that we'll get all characters back that are sent to the COM port.

The procedure depends on your host system. Select the tab that matches your host:

{% include content/tab/start.md tabs="ModuCop, OtherLinuxHost" instance="serial-host" %}


<!--
==========================================================================================
ModuCop Host TAB
==========================================================================================
-->
{% include content/tab/entry-start.md %}

### Access {{ page.product_name }} COM port from ModuCop

Preparation Steps:
* Ensure you have configured the network and device ID for the {{ page.product_name }} as shown above
* Connect a PC, ModuCop, and {{ page.product_name }} to the same network, e.g. by using an Ethernet Switch or a Wifi Access Point
* From the PC, login into the ModuCop via ssh

#### Check whether {{ page.product_name }} COM ports are recognized on ModuCop

ModuCop's linux image is configured to detected COM Ports of io4edge devices automatically.

For each detected COM port, a linux device `/dev/tty<device-ID>-com<port>` is created. For example, if your {{ page.product_name }} device ID is `{{ page.product_name }}-1`, you'll find the following tty devices:

```bash
root@moducop-cpu01: ~# ls -l /dev/tty{{ page.product_name }}*
crw-rw---- 1 root dialout 199, 3 Jul 28 13:33 /dev/tty{{ page.product_name }}-1-com1
crw-rw---- 1 root dialout 199, 4 Jul 28 13:33 /dev/tty{{ page.product_name }}-1-com2
```

#### Function Test
Now, let's make a hardware loop between the RS232 transmit and receive pin of the COM1 RS232 interface. Connect pin 2 and 3 of the COM ports D-Sub connector:

![COM Loop]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou04/iou04-qs-com-loop.svg' | relative_url }}){: style="width: 10%"}

Start the `minicom` terminal program on ModuCop:
```bash
root@moducop-cpu01: ~# minicom -D /dev/tty{{ page.product_name }}-1-com1 -b 115200
```
Because we haven't connected hardware flow control lines, we have to tell minicom not to use hardware flow control:
* Press `CTRL-A` followed by `O` (O like Omega)
```

            ┌─────[configuration]──────┐
            │ Filenames and paths      │
            │ File transfer protocols  │
            │ Serial port setup        │
            │ Modem and dialing        │
            │ Screen and keyboard      │
            │ Save setup as dfl        │
            │ Save setup as..          │
            │ Exit                     │
            └──────────────────────────┘
```
* Select `Serial Port Setup`
* Press `F`

Then hardware flow control should be off:
```
F - Hardware Flow Control : No
```
Press two times `ESC` and you are back in the main screeen of minicom.

Now type some character, and you should see that the characters are echoed back, due to the hardware loop we have created!

```
Welcome to minicom 2.7.1

OPTIONS: I18n
Compiled on Apr 18 2017, 09:55:23.
Port /dev/tty{{ page.product_name }}-1-com1, 13:45:27

Press CTRL-A Z for help on special keys

dddddddddddd..ffffdddddddddddddddd
```

To leave minicom, type `CTRL-A`, followed by `x`.

{% include content/tab/entry-end.md %}

<!--
==========================================================================================
Other Linux Host TAB
==========================================================================================
-->
{% include content/tab/entry-start.md %}

### Access {{ page.product_name }} COM port from any Linux Host

To access the {{ page.product_name }} COM ports from a linux host, the easiest way is to use the user space program `ttynvt` that creates a virtual `tty` device on the host and forwards all host accessed via network to the {{ page.product_name }}.


#### `ttynvt` installation

{% include content/io4edge/ttynvt/build.md %}

#### Start `ttynvt`

In a first terminal, start a temporary instance of `ttynvt`.

```bash
# From the folder where you have built ttynvt
$ sudo src/ttynvt -f -E -M 384 -m 1 -S <ip-address-of-your-device>:10000 -n ttyNVT0
```

This will create a new device `/dev/ttyNVT0`

```bash
$ ls -l /dev/ttyNVT0
crw-rw---- 1 root dialout 384, 1 Jul 28 16:05 /dev/ttyNVT0
```

#### Function Test
Now, let's make a hardware loop between the RS232 transmit and receive pin of the COM1 RS232 interface. Connect pin 2 and 3 of the COM ports D-Sub connector:

![COM Loop]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou04/iou04-qs-com-loop.svg' | relative_url }}){: style="width: 10%"}

In a second terminal, start `picocom` terminal program.

Then type some character, and you should see that the characters are echoed back, due to the hardware loop we have created!

```bash
$ picocom /dev/ttyNVT0 -b 115200
...
Terminal ready

dddddddddddd..ffffdddddddddddddddd
```

To leave picocom, type `CTRL-A`, followed by `CTRL-X`.

{% include content/tab/entry-end.md %}

{% include content/tab/end.md %}
