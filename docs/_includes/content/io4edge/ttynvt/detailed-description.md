<!---
Features and connections shall be described by the including file (e.g. iou04-front/detailed-description.md)

Pass the following parameters in the include directive:
- single_tty: "true" if the device has only one tty (e.g. iou06), "false" if it has multiple ttys (e.g. iou04)
- example_port_ext: extension of the example port name (e.g. "com" or "com1")
- example_port_num: TCP port number of the example port (e.g. "10000" )
- have_hwhandshake: "true" if the device has hardware handshake, "false" if not
--->

### Operating Principle of IP Based COM-Port

{% if include.single_tty == "false" %}
{% assign port = "ports" %}
COM ports on the {{ page.product_name }} are exposed to the network as a `ttynvt` (network virtual terminal) service. For each COM port, a TCP-Server, implementing the [RFC2217](https://datatracker.ietf.org/doc/html/rfc2217) protocol is active on the {{ page.product_name }}, each TCP-Server uses a dedicated TCP port.
{% else %}
{% assign port = "port" %}
The COM port on the {{ page.product_name }} is exposed to the network as a `ttynvt` (network virtual terminal) service. For the COM port, a TCP-Server, implementing the [RFC2217](https://datatracker.ietf.org/doc/html/rfc2217) protocol is active on the {{ page.product_name }}.
{% endif %}


RFC2217 extends the telnet protocol by adding COM port configuration commands, flow control and more. In addition to RFC2217 standard, we have added a proprietary extension for {{ page.product_name }} to control half duplex operation. (See `TNS_CTL_ENABLE_RS485` and `TNS_CTL_DISABLE_RS485` in the [telnet header file](https://gitlab.com/ci4rail/ttynvt/-/blob/master/src/telnet.h))

{% if page.article_group == "S103" %}
**WARNING** RFC2217 is a protocol without any security measures. Please use it only in trusted, closed networks!
{: .notice--warning}
{% endif %}

To access the COM {{ port }} from the host, you can
* Use the [ttynvt](https://gitlab.com/ci4rail/ttynvt) program to create a virtual `/dev/tty` device for each COM port.
* Use pyserial's [RFC2217 support](https://pyserial.readthedocs.io/en/latest/url_handlers.html?highlight=rfc2217#rfc2217)

### Using ttynvt

An instance of `ttynvt` must be started for each virtual RFC2217 COM port. `ttynvt` creates a device entry in `/dev`, e.g. `/dev/tty{{ page.example_device_name }}-{{ include.example_port_ext }}`. Your application can then use this device as any other `tty` device in the system.

{% if page.article_group == "S103" %}
{% include content/tab/start.md tabs="Ci4Rail-Linux-Image, Other-Linux" instance="host" %}

<!--
==========================================================================================
Ci4Rail Image
==========================================================================================
-->
{% include content/tab/entry-start.md %}
#### Ci4Rail Linux Image
{% endif %}

If you are using a Linux Image from Ci4Rail, `ttynvt` instances are automatically started for each ttynvt COM port in the network via [ttynvt-runner](https://github.com/ci4rail/ttynvt-runner). `ttynvt-runner` is started as a `systemd` service.

{% if page.article_group == "S103" %}
{% include content/tab/entry-end.md %}
{% include content/tab/entry-start.md %}
<!--
==========================================================================================
Non Ci4Rail Image
==========================================================================================
-->

#### Linux Images without ttynvt support

If ttynvt isn't integrated in your Linux Image, follow this section.

##### Compile ttynvt

{% include content/io4edge/ttynvt/build.md %}

##### Start ttynvt

Start ttynvt as root:

```bash
$ ttynvt -f -E -M <major-number> -m <minor-number> -S <device-ip-address>:<port-number> -n <tty-devicename>
```

Parameters:

| Parameter         | Description                                                                                                                                    |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| major number      | The major number identifies the driver associated with the device. Select for the ttynvt driver a number that is not yet in use in your system |
| minor number      | Provide a new minor number for each device. Select a number between 1 and 255                                                                  |
| device-ip-address | The IP address of your {{ page.product_name }}                                                                                                 |
| port-number       | The port number in your {{ page.product_name }} associated with the COM port                                                                   |
| tty-devicename    | The name to create for the device. E.g. `tty{{ page.example_device_name }}-com1`                                                               |

To find the IP address and Port, ensure `avahi` and `avahi-utils` are installed on host and run `avahi-browse`. Example:

```bash
$ avahi-browse -rt _ttynvt._tcp
+ enp5s0 IPv4 {{ page.example_device_name }}-com1                                  _ttynvt._tcp         local
+ enp5s0 IPv4 {{ page.example_device_name }}-com2                                  _ttynvt._tcp         local
= enp5s0 IPv4 {{ page.example_device_name }}-com1                                  _ttynvt._tcp         local
   hostname = [{{ page.example_device_name }}.local]
   address = [192.168.24.89]
   port = [10000]
   txt = ["funcclass=ttynvt" "security=no" "auxport=not_avail-0" "auxschema=not_avail"]
= enp5s0 IPv4 {{ page.example_device_name }}-com2                                  _ttynvt._tcp         local
   hostname = [{{ page.example_device_name }}.local]
   address = [192.168.24.89]
   port = [10001]
   txt = ["funcclass=ttynvt" "security=no" "auxport=not_avail-0" "auxschema=not_avail"]
```

##### Autostart of ttynvt

Instead of starting `ttynvt` manually, you can use [ttynvt-runner](https://github.com/ci4rail/ttynvt-runner). `ttynvt-runner` starts `ttynvt` automatically for each virtual COM port in the network.

{% include content/tab/entry-end.md %}
{% include content/tab/end.md %}

<!--
==========================================================================================
End Image Tab
==========================================================================================
-->
{% endif %}


#### Using Half Duplex Mode with ttynvt

Half duplex mode must be used with the RS485/RS422 signals on the connector. In half duplex mode, two or more participants share the Rx/Tx lines. Only one participant is allowed to drive the Tx data.

To enable half duplex mode, the application must call iotcl `TIOCSRS485` on the tty device provided by `ttynvt`. In python, this can be done like this:

```python
import serial
import serial.rs485

ser = serial.Serial(
                port="/dev/{{ page.example_device_name }}-{{include.example_port_ext }}",
                baudrate = 115200,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                bytesize=serial.EIGHTBITS,
                timeout=1,
                rtscts = False
            )

# Set half duplex operation
ser.rs485_mode = serial.rs485.RS485Settings()

ser.write(bytes("Hello World", "utf8"))

data = ser.read(10)
print("data: {}".format(data))
```

**NOTE**: In half duplex mode, the data that is sent to the line is *NOT* echoed back to the application, because the receiver is disabled while sending.
{: .notice--info}


### Using pyserial with RFC2217

`pyserial` provides a way to communicate directly with RFC2217 compliant servers, this way, `ttynvt` is not required.

The following example opens COM1 of the {{ page.product_name}} with device id `{{ page.example_device_name }}` (port 10000 is the port for `COM1`), sets the baudrate to 19200 and sends and receives some characters:

```python
import serial

ser = serial.serial_for_url("rfc2217://{{ page.example_device_name }}.local:{{ include.example_port_num }}?ign_set_control")
ser.baudrate = 19200

ser.write(bytes("Hello World", "utf8"))

data = ser.read(10)
print("data: {}".format(data))

```
**NOTE** pyserial with RFC2217 does not support the proprietary extension to set the COM port into half duplex mode. Therefore, half-duplex mode is not supported.
{: .notice--info}


### Considerations when running with Handshaking enabled

{% if include.have_hwhandshake=="true" %}
The COM port supports hardware (CTS/RTS) and software (XON/XOFF) handshaking for flow control. A receiver may stop the sender by de-asserting CTS or sending an XOFF character.
{% else %}
The COM port supports software (XON/XOFF) handshaking for flow control. A receiver may stop the sender by sending an XOFF character.
{% endif %}


However, be aware about the following behaviour:
When the {{ page.product_name }} is the sender and the connected receiver forces the transmission to stop, the {{ page.product_name }} may hang until the transmission is re-enabled again by the receiver. Even if you stop the transmitting process, the firmware will not accept any new connection request until its transmit buffer gets empty.

If you run into such a situation and the receiver will never re-enable the transmission {% if include.have_hwhandshake=="true" %}(for example because you have selected hardware handshake but you haven't connected CTS){% endif %}, you must restart the {{ page.product_name }}, for example using the `io4edge-cli`.
