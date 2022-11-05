<!---
Pass the following parameters in the include directive:
- total_channels: The total number of channels
- num_groups: The number of groups
--->
### Features

The {{ page.product_name }} has a binary I/O function block providing {{ include.total_channels }} IEC 61131-2 compliant channels, corresponding to {{ include.total_channels }}  I/O pins.
* {{ include.num_groups }} galvanically isolated groups, each with {{ include.total_channels / include.num_groups }} channels
* Each pin can be used as a
  * binary output with read-back
  * binary input
* Each channel configured as an output can switch the load to ground or to supply
* Supply voltage of each group may be between 17VDC and 36VDC. Each group may use a different supply voltage.
* Switching capability of each pin is 300mA for the high side switch and 200mA for low side switch.
* Input circuit IEC 61131-2 Type 1/3 compliant, each pin draws 2.3mA (typ) to ground.
* Switching level of the input is 6.7V to 8V, with 1.2V hysteresis
* Per-Channel LED that reflects the input state. In case of overcurrent or overload on a channel, LED is flashing fast.
* Configurable output watchdog, to reset outputs in case host application crashed
* Max. Input Acquisition Frequency for Stream: 500Hz
* Max. Output Frequency: 20Hz (limited by the io4edge direct I/O interface)

### Channel Principles
![Binary I/O Channel Pricnciple]({{ '/user-docs/images/edge-solutions/io4edge/max14906/channel-principle.svg' | relative_url }})

### Connection

Each binary I/O group has its own connector with the following pinout:


| Pin | Symbol | Description                 |
| --- | ------ | --------------------------- |
| 1   | +      | Positive Supply Voltage     |
| 2   | IO1    | First I/O pin of the group  |
| 3   | IO2    | Second I/O pin of the group |
| 4   | IO3    | Third I/O pin of the group  |
| 5   | IO4    | Fourth I/O pin of the group |
| 6   | -      | Supply Voltage Ground       |

{% include content/io4edge/iou01-front/mating-connectors.md %}

### Use Cases

#### How to Connect the Load
Load may be connected to ground (high side switch) or to supply (low side switch).
Be aware that high side switch can drive stronger current (300mA) than the low side switch (200mA).

![Connect Load]({{ '/user-docs/images/edge-solutions/io4edge/max14906/use-case-output1.svg' | relative_url }})


#### Using Inputs

In case you want to use a pin as input, you can
* monitor a switch to that is connected to supply
* monitor a voltage source, referenced to ground

The switching level of the input is 6.7V to 8V, with 1.2V hysteresis.

![Use Inputs]({{ '/user-docs/images/edge-solutions/io4edge/max14906/use-case-inputs.svg' | relative_url }})


### Using the io4edge API to access the Binary I/Os

If you haven't installed yet the io4edge client software, install it now as [described here]({{ page.url | append: "../quick-start-guide" | relative_url }}#getdemosoftware).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-go/tree/main/examples/binaryIoTypeC)

#### Connect to the binary I/O function

To access the binary I/Os, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ page.example_device_name }}-{{ example_service_ext }}`
* As an IP/Port: `192.168.201.1:10000`

We need this client variable for all further access methods.

```go
import (
  "time"
  "log"
  binio "github.com/ci4rail/io4edge-client-go/binaryiotypec"
  biniopb "github.com/ci4rail/io4edge_api/binaryIoTypeC/go/binaryIoTypeC/v1alpha1"
)

func main() {
    c, err := binio.NewClientFromUniversalAddress(address, time.Second)
    if err != nil {
        log.Fatalf("Failed to create binio client: %v\n", err)
    }
}
```

#### Configure the binary I/Os

The binary I/Os can be configured as input or output. The default configuration is input.

With the `UploadConfig` method, you can change the configuration of the binary I/Os. The configuration is a list of `ChannelConfig` structs. Each struct contains the channel number, the channel mode and its *initial* value. The channel number is 0-based. The channel mode is either `ChannelMode_BINARYIOTYPEC_OUTPUT_PUSH_PULL` or `ChannelMode_BINARYIOTYPEC_INPUT_TYPE_1_3`.

Channels that are not specified in the `ChannelConfig` list are not changed.

For example, to configure channel 0..3 as output and leave the rest of the channels unchanged, use the following code:

```go
  channnelConfig := make([]*biniopb.ChannelConfig, 4)
  for i := 0; i < 4; i++ {
    channnelConfig[i] = &biniopb.ChannelConfig{
      Channel:      int32(i),
      Mode:         biniopb.ChannelMode_BINARYIOTYPEC_OUTPUT_PUSH_PULL,
      InitialValue: false,
    }
  }
  if err := c.UploadConfiguration(
    binio.WithChannelConfig(channnelConfig),
  ); err != nil {
    log.Fatalf("Failed to upload configuration: %v\n", err)
  }
```

#### Controlling Output Values

The API provides two methods to control channel output values
* Control a single pin
* Control multiple pins

Control a single pin:
```go
    // output high value on first channel
    err = c.SetOutput(0, true)
```

Control multiple pins using a bit mask. The second parameter to `SetAllOutputs` is a mask that specifies which channels are affected:
```go
    // set first binary output to high, set second output to low, don't change other channels
    err := c.SetAllOutputs(0x1, 0x3)

    // set first 4 channels to low, don't change other channels
    err := c.SetAllOutputs(0x0, 0xf)
```

The `SetOuput` and `SetAllOutputs` methods return an error if
* the channel number is out of range
* a channel that shall receive a new output value is configured as input
* the channel's group has no power

The actual pin state of channels configured as outputs can be read back using the `Input` and `AllInputs` methods below.

#### Output Watchdog

By default, the outputs keep their commanded state forever, even if the host program has terminated or crashed.

To ensure that outputs are turned off in such cases, the firmware implements a watchdog functionality. The watchdog can be enabled per channel and the watchdog timeout is configurable (but is the same for all channels).

```go
    // set 2 seconds watchdog on first channel, but not on other channels
    if err := c.UploadConfiguration(binio.WithOutputWatchdog(0x1, 2000)); err != nil {
      log.Fatalf("Failed to set configuration: %v\n", err)
    }
```

With that setting, the host must periodically set each of the enabled channels to the *active* value (the opposite of the *inactive* value) within 2 seconds. If the host does not set the channel within the watchdog timeout, the firmware sets back the channel to its *initial* value.

#### Overcurrent and Overload Handling

The channel outputs are overcurrent and overload protected. In case an overcurrent condition is detected on one output, the channel limits the current to its maximum (300mA for high side switch, 200mA for low side switch).

In addition, the binary ouptuts detect thermal overload condition. In this case the channel is disabled until the the channel's temperature falls below a certain threshold, then the channels output is activated again.

Overcurrent and overload conditions are reported via the diagnostic values returned by the `Input` and `AllInputs` method.

#### Reading Inputs and Channel Diagnostics

The API provides two methods to read the current state of the pins:
* Get value of a single pin
* Get value of multiple pins

```go
    // read state of first channel
    // value will be true, if the level is above the input switching threshold
    // diag returns the diagnostic value
    value, diag, err := c.Input(0)

    // check for channel diagnostics
    if diag&uint32(biniopb.ChannelDiag_CurrentLimit) != 0 {
      // channel is in current limit state
    }
    if diag&uint32(biniopb.ChannelDiag_NoSupplyVoltage) != 0 {
      // channel's group has no supply voltage
    }

    // read state of all channels.
    // values contains then a bit mask with the state of each input
    // diag is a list of diagnostic values, one for each channel
    values, diag, err := c.AllInputs()

    // check for diagnostics of second channel 
    if diag[1]&uint32(biniopb.ChannelDiag_CurrentLimit) != 0 {
      // channel is in current limit state
    }

```

The diagnostic value(s) contain a bit mask with the following flags:
* `ChannelDiag_NoSupplyVoltage`: The channel's group has no power
* `ChannelDiag_CurrentLimit`: The channel is in current limit mode
* `ChannelDiag_Overload`: The channel is in overload mode
* `ChannelDiag_SupplyUndervoltage`: The channel's supply voltage is below the minimum voltage	(<17V)
* `ChannelDiag_SupplyOvervoltage`: The channel's supply voltage is above the maximum voltage (>43V). However, this flag is never set as long as the hardware isn't damaged.

### Input Transient Recording

In data logger applications, you may want to record changes of the channels.

Therefore, the API provides functions to start a *Stream*. At stream creation, you select the channels which you want to monitor for changes.

The {{ page.product_name }} samples the channel values at a rate of 1.25kHz, so the timestamps are accurate to 800us.

```go
// start stream, watch for changes on first two channels
err = c.StartStream(binio.WithChannelFilterMask(0x3))
```

For each transition, a *Sample* is generated in the stream, each sample contains:
* A timestamp of the transition
* The value of all channels at the time of the transition (with the exception of the channels that are filtered out)
* A bit mask that indicates if the corresponding channel value is valid

For efficiency, multiple samples are gathered are sent as one *Bucket* to the host.
To read samples from the stream:

```go
  firstTs := uint64(0)
  for {
    // read next bucket from stream
    sd, err := c.ReadStream(time.Second * 5)

    if err != nil {
      log.Fatalf("ReadStreamData failed: %v\n", err)
    } else {
      samples := sd.FSData.GetSamples()
      log.Printf("got stream data seq=%d ts=%d samples=%d\n", sd.Sequence, sd.DeliveryTimestamp, len(samples))

      for i, sample := range samples {
        if firstTs == 0 {
          firstTs = sample.Timestamp
        }
        log.Printf("sample %d: relTs=%10dus values=b%016b valid=b%016b", i, sample.Timestamp-firstTs, sample.Values, sample.ValueValid)
      }
    }
    if time.Since(start) > time.Second*time.Duration(*runtime) {
      break
    }
  }
```

{% include content/io4edge/functionblock/timestamp.md %}

#### Controlling the Stream

{% capture example_keep_alive %}
```go
  // configure stream to send the bucket at least once a second
  err = c.StartStream(
    binio.WithFBStreamOption(functionblock.WithKeepaliveInterval(1000)),
  )
```
{% endcapture %}


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

{% include content/io4edge/functionblock/stream-common.md example_keep_alive=example_keep_alive example_all_options=example_all_options describe_low_latency=true %}

#### Multiple Clients

It is possible to have multiple clients. Example usage:
* Each client has its own stream. One client may have a stream that records transitions on channel #1, while another client records transitions on channel #2, #3 and #4.
* One client is reading the current state of the channels, while another client is recording transitions and a third client is writing to a channel.
