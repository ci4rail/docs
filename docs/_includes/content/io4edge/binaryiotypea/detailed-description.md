### Features

The {{ page.product_name }} has a binary I/O function block with 4 channels, corresponding to 4 I/O pins.
* 2 galvanically isolated groups, group1=I/O 1/2, group2=I/O 3/4
* Each pin can be used as a
  * binary output with read-back
  * binary input
* Each group may switch the load to ground or to supply
* Pins are overcurrent protected
* The input circuit of each pin draws 0.5mA, and supports a configurable fritting function, that draws 10mA for a short moment.
* Supply voltage of each group may be between 24VDC and 110VDC nominal.
* Switching capability of each pin is at least 1A.
* Each pin has a LED that reflects the input state. In case of overcurrent, all 4 LEDs are flashing fast.
* Configurable output watchdog, to reset outputs in case host application crashed
* Max. Input Frequency: 50Hz
* Max. Output Frequency: 50Hz
* Max. Inductive Load: 20 mH

![Binary I/O Groups Principle]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/groups-principle.svg' | relative_url }})

### Connection

Each binary I/O group has its own connector:

![Binary I/O Groups Principle]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/conn.svg' | relative_url }})

| Pin | Symbol | Description                                     |
| --- | ------ | ----------------------------------------------- |
| 1   | CI     | Common Reference voltage for inputs             |
| 2   | IO1/3  | First I/O pin of the group                      |
| 3   | IO2/4  | Second I/O pin of the group                     |
| 4   | CO     | Common Voltage connected to the output switches |

{% include content/io4edge/iou01-front/mating-connectors.md %}

### Use Cases

#### How to Connect the Load
Load may be connected to ground (high side switch) or to supply (low side switch).

![Connect Load]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-output1.svg' | relative_url }})

**Warning** Do not leave the CI pin open! If the CI pin is left open, one I/O may affect the read-back level of the other I/O!
{: .notice--warning}


#### Using Inputs

In case you want to use a pin as input, you can select whether the input needs to be driven to high or low.
The switching threshold of the input is ~10V with a hysteresis of ~200mV.

![Use Inputs]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-inputs.svg' | relative_url }})

#### Controlling a DC Motor

This example shows how you can control a DC Motor in both directions:

**Warning** When changing direction, open the currently closed contacts first, ensure they are open before closing the complementary switch (brake before make)!
{: .notice--warning}

![DC Motor Application]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-motor.svg' | relative_url }})

#### Mixed Application

This example shows how you can use one pin of a group as input and the other pin as output. It also shows that you can supply each group with a different voltage:

![Mixed Application]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-mixed-voltage.svg' | relative_url }})


### Using the io4edge API to access the Binary I/Os

{% include content/io4edge/functionblock/install-client.md example_name="binaryIoTypeA" %}

#### Connect to the binary I/O function

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

To access the binary I/Os, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ page.example_device_name }}-{{ example_service_ext }}`
* As an IP/Port: `192.168.201.1:10002`

We need this client variable for all further access methods.

```go
import (
  "time"
  log "github.com/sirupsen/logrus"
  binio "github.com/ci4rail/io4edge-client-go/binaryiotypea"
)

func main() {
    c, err := binio.NewClientFromUniversalAddress(address, time.Second)
    if err != nil {
        log.Fatalf("Failed to create binio client: %v\n", err)
    }
}
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
To access the binary I/Os, create a *Client* and save it to the variable `binio_client`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ page.example_device_name }}-{{ example_service_ext }}`
* As an IP/Port: `192.168.201.1:10002`

We need this client variable for all further access methods.

```python

import io4edge_client.binaryiotypea as binio
import io4edge_client.functionblock as fb

def main():
  binio_client = binio.Client(address)
```

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Configure the binary I/Os

The following attributes can be configured:
* Output watchdog
* Input fritting

You don't need to configure the direction of the channels: As long as you don't activate the output switch, the channel is an input.

##### Output Watchdog
By default, the outputs keep their commanded state forever, even if the host program has terminated or crashed.

To ensure that outputs are turned off in such cases, the firmware implements a watchdog functionality. The watchdog can be enabled per pin and the watchdog timeout is configurable (but is the same for all pins).

When you enable the watchdog and set the timeout to 2000, the host must periodically set the switch to "on" within 2 seconds. If it fails to do so, the firmware turns off the output.

##### Fritting

The current drawn by the input circuitry is 0.5mA. To avoid contact corrosion, it is advisable to draw a higher current from time to time. Therefore, the {{ page.product_name }} supports an optional fritting pulse that applies a 10mA pulse for 10ms each second.

##### Apply the configuration

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
The go API allows to configure each attribute individually, for example:

Set 2 seconds watchdog on output0, but not on other outputs:
```go
    if err := c.UploadConfiguration(binio.WithOutputWatchdog(0x1, 2000)); err != nil {
      log.Fatalf("Failed to set configuration: %v\n", err)
    }
```
Enable fritting for all inputs:
```go

    if err := c.UploadConfiguration(binio.WithInputFritting(0xf); err != nil {
      log.Fatalf("Failed to set configuration: %v\n", err)
    }
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->

Enable fritting on channel #1, #2, #3 and #4, enable watchdog on channel #1 and #2 and set the watchdog timeout to 2 seconds:
```python
    config = binio.Pb.ConfigurationSet(outputFrittingMask=0xf,
                                       outputWatchdogMask=0x3,
                                       outputWatchdogTimeout=2000)
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Controlling Output Switches

The API provides two methods to control output switches
* Control a single pin
* Control multiple pins

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
Control a single pin:
```go
    // switch on binary output #1
    err = c.SetOutput(0, true)
```

Control multiple pins using a bit mask. The second parameter to `SetAllOutputs` is a mask that specifies which outputs are affected:
```go
    // switch on binary output #1, turn off output #2, don't change output #3 and #4
    err := c.SetAllOutputs(0x1, 0x3)

    // switch off all outputs
    err := c.SetAllOutputs(0x0, 0xf)
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->

Control a single pin:
```python
    # switch on binary output #1
    binio_client.set_output(0, True)
```
Control multiple pins using a bit mask. The second parameter to `set_all_outputs` is a mask that specifies which outputs are affected:
```python
    # switch on binary output #1, turn off output #2, don't change output #3 and #4
    binio_client.set_all_outputs(0x1, 0x3)

    # switch off all outputs
    binio_client.set_all_outputs(0x0, 0xf)
```

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Overcurrent Protection

The outputs are overcurrent protected. In case an overcurrent condition is detected on one output, ALL outputs are disabled. The firmware attempts after some milliseconds to turn on the previously closed switches again, because the overcurrent may come from a capacitive load or from a temporary short circuit.

If after approx. 50ms the overcurrent condition still remains, ALL outputs enter an error state.
* In the error state, no outputs can be set; inputs can still be read.
* During error state, all 4 LEDs are flashing fast

Application may clear the error state (in case application knows that the root cause of the error vanished):

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
    err := c.ExitErrorState()
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    binio_client.exit_error_state()
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

This tells the binary output controller to try again. It does however not wait if the recovery was successful or not.

#### Reading Inputs

The API provides two methods to read the current state of the pins:
* Get value of a single pin
* Get value of multiple pins

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
    // read state of I/O #1
    // value will be true, if the level is above the input switching threshold
    value, err := c.Input(0)

    // read state of I/O #1 and #2.
    // values contains then a bit mask with the state of each input
    values, err = c.AllInputs(0x3)
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    # read state of I/O #1
    # value will be true, if the level is above the input switching threshold
    value = binio_client.input(0)

    # read state of I/O #1 and #2.
    # values contains then a bit mask with the state of each input
    values = binio_client.all_inputs(0x3)
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Input Transient Recording

In data logger applications, you may want to record changes of the inputs.

Therefore, the API provides functions to start a *Stream*. At stream creation, you select the pins which you want to monitor for changes.

The {{ page.product_name }} samples the channel values at a rate of 100Hz, so the timestamps are accurate to 10ms.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
// start stream, watch for changes on I/O #1 and 2
err = c.StartStream(binio.WithChannelFilterMask(0x3))

// alternatively, use the defaults, i.e. watch for changes on all 4 pins
err = c.StartStream()

```

For each transition, a *Sample* is generated in the stream, each sample contains:
* A timestamp of the transition
* The pin that changed
* New value of the pin

For efficiency, multiple samples are gathered and sent as one *Bucket* to the host.
To read samples from the stream:

```go
  for {
    // read next bucket from stream
    sd, err := c.ReadStream(time.Second * 1)

    if err != nil {
      log.Errorf("ReadStreamData failed: %v\n", err)
    } else {
      samples := sd.FSData.GetSamples()
      fmt.Printf("got stream data seq=%d ts=%d\n", sd.Sequence, sd.DeliveryTimestamp)

      for i, sample := range samples {
        fmt.Printf("  #%d: ts=%d channel=%d %t\n", i, sample.Timestamp, sample.Channel, sample.Value)
      }
    }
  }
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
{% capture example_all_options_py %}
```python
    # start stream, watch for changes on I/O #1 and 2
    binio_client.start_stream(
        binio.Pb.StreamControlStart(channelFilterMask=0x3),
        fb.Pb.StreamControlStart(
            bucketSamples=25,
            keepaliveInterval=1000,
            bufferedSamples=50,
            low_latency_mode=True,
        ),
    )
```
{% endcapture %}

{{ example_all_options_py }}

For each transition, a *Sample* is generated in the stream, each sample contains:
* A timestamp of the transition
* The pin that changed
* New value of the pin

For efficiency, multiple samples are gathered and sent as one *Bucket* to the host.
To read samples from the stream:

```python
    while True:
        generic_stream_data, stream_data = binio_client.read_stream()
        print(
            f"Received stream data {generic_stream_data.deliveryTimestampUs}, {generic_stream_data.sequence}"
        )
        for sample in stream_data.samples:
            print(" Channel %d -> %d" % (sample.channel, sample.value))
```


<!--- PYTHON END --->
{% include content/tabv2/end.md %}

{% include content/io4edge/functionblock/timestamp.md %}

#### Controlling the Stream


{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

{% capture example_all_options %}
```go
  // configure stream to send the bucket at least once a second
  // configure the maximum samples per bucket to 25
  // configure low latency mode
  // configure the buffered samples to 200
  err = c.StartStream(
      binio.WithFBStreamOption(functionblock.WithKeepaliveInterval(1000)),
      binio.WithFBStreamOption(functionblock.WithBucketSamples(25)),
      binio.WithFBStreamOption(functionblock.WithLowLatencyMode(true))
      binio.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-go.md example_all_options=example_all_options describe_low_latency=true %}

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->


{% include content/io4edge/functionblock/stream-common-python.md example_all_options=example_all_options_py describe_low_latency=true %}

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Multiple Clients

It is possible to have multiple clients. Example usage:
* Each client has its own stream. One client may have a stream that records transitions on I/O #1, while another client records transitions on I/O #2, #3 and #4.
* One client is reading the current state of the I/Os, while another client is recording transitions and a third client is writing to an I/O.
