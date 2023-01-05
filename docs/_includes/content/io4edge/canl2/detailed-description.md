
<!---
Pass the following parameters in the include directive:
- listenonly: "true" or "false"
- connector: the connector description
- link_to_static_busconfiguration
- link_to_socketcan_qs
- link_to_getdemosoftware
--->
{% assign example_service_name = page.example_device_name | append: "-can" %}
### Features

* ISO 11898 CANBus Interface, up to 1MBit/s
* Usable for direct I/O or as data logger with multiple data streams.
* SocketCAN Support
* Standard and Extended Frame Support
* RTR Frame Support
* {% if inclue.listenonly == "false" %}Optional{% else %}Fixed{% endif %} Listen Only Mode
* One Acceptance Mask/Filter

### Connection

{{ include.connector }}


### Using the io4edge API to access CAN Function

If you haven't installed yet the io4edge client software, install it now as [described here]({{ link_to_getdemosoftware }}).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-go/tree/main/examples/canL2)

#### Connect to the CAN Function

To access the CAN Function, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ example_service_name }}`
* As a IP/Port: e.g. `192.168.201.1:10002`

We need this client variable for all further access methods.

```go
import (
  "fmt"
  "os"
  "time"
  "github.com/ci4rail/io4edge-client-go/canl2"
  fspb "github.com/ci4rail/io4edge_api/canL2/go/canL2/v1alpha1"
)

func main() {
  const timeout = 0 // use default timeout

  c, err := canl2.NewClientFromUniversalAddress("{{ example_service_name }}", timeout)
  if err != nil {
    log.Fatalf("Failed to create canl2 client: %v\n", err)
  }
}
```

#### Bus Configuration

There are two ways to configure the CAN function:

* Using a persistent parameter that is stored in the flash of the {{ page.product_name }}, as described [here]({{ link_to_static_busconfiguration }}).
* Temporarily, via the io4edge CANL2 API, as shown below

##### Temporary Bus Configuration

Bus Configuration can be set via `UploadConfiguration`. All settings remain active until you change it again or restart the device.

When the device is restarted, it will apply the persistent configuration stored in flash, or - if no persistent configuration is available - will keep the CAN controller disabled.

```go
  err = c.UploadConfiguration(
    canl2.WithBitRate(125000),
    canl2.WithSamplePoint(0.625),
    canl2.WithSJW(1),
    {% if inclue.listenonly == "false" %}canl2.WithListenOnly(false),{% else %}canl2.WithListenOnly(true),{% endif %}
  )
```

#### Receiving CAN Data

To receive data from the CANbus, the API provides functions to start a *Stream*.

Without any parameters, the stream receives all CAN frames:
```go
// start stream
err = c.StartStream()
```
Missing parameters to ´StartStream` will take default values:
* Filter off (let all CAN frames pass through)
* Maximum samples per bucket: 25
* Buffered Samples: 50
* Keep Alive Interval: 1000ms
* Low Latency Mode: off


In the stream the firmware generates *Buckets*, where each Bucket contains a number of *Samples*. Each sample contains:
* A timestamp of the sample
* The CAN frame (may be missing in case of bus state changes or error events)
* The CAN Bus state (Ok, error passive or bus off)
* Error events (currently: receive buffer overruns)

For efficiency, multiple samples are gathered are sent as one *Bucket* to the host.
To read samples from the stream:

```go
  for {
    // read next bucket from stream
    sd, err := c.ReadStream(time.Second * 5)

    if err != nil {
      log.Printf("ReadStreamData failed: %v\n", err)
    } else {
      samples := sd.FSData.Samples
      fmt.Printf("got stream data with %d samples\n", len(samples))

      for _, s := range samples {
        fmt.Printf("  %s\n", dumpSample(s))
      }
    }
  }

func dumpSample(sample *fspb.Sample) string {
  var s string

  s = fmt.Sprintf("@%010d us: ", sample.Timestamp)
  if sample.IsDataFrame {
    f := sample.Frame
    s += "ID:"
    if f.ExtendedFrameFormat {
      s += fmt.Sprintf("%08x", f.MessageId)
    } else {
      s += fmt.Sprintf("%03x", f.MessageId)
    }
    if f.RemoteFrame {
      s += " R"
    }
    s += " DATA:"
    for _, b := range f.Data {
      s += fmt.Sprintf("%02x ", b)
    }
    s += " "
  }
  s += "ERROR:" + sample.Error.String()
  s += " STATE:" + sample.ControllerState.String()

  return s
}

```

{% include content/io4edge/functionblock/timestamp.md %}


##### Controlling the Stream

{% capture example_keep_alive %}
```go
  // configure stream to send the bucket at least once a second
  err = c.StartStream(
    canl2.WithFBStreamOption(functionblock.WithKeepaliveInterval(1000)),
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
      canl2.WithFBStreamOption(functionblock.WithKeepaliveInterval(1000)),
      canl2.WithFBStreamOption(functionblock.WithBucketSamples(25)),
      canl2.WithFBStreamOption(functionblock.WithLowLatencyMode(true))
      canl2.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-go.md example_keep_alive=example_keep_alive example_all_options=example_all_options describe_low_latency=true %}


If you don't want to receive all CAN identifiers, you can specify an acceptance code and mask that is applied to each received frame. The filter algorithm is `pass_filter = (code & mask) == (received_frame_id & mask)`.
The same filter is applied to extended frames and standard frames.

```go
  // apply a filter. Frames with an identifier of 0x1xx pass the filter, other frames are filtered out
  code := 0x100
  mask := 0x700
  err = c.StartStream(
    canl2.WithFilter(code, mask),
  )
```

##### Error Indications and Bus State

The samples in the stream contain also error events and the current bus state.

Error events can be:
* `ErrorEvent_CAN_NO_ERROR` - no event
* `ErrorEvent_CAN_RX_QUEUE_FULL` - either the CAN controller dropped a frame or the stream buffer was full

Each sample contains also the bus state. When the bus state changes, a sample without a CAN frame may be generated.
Furthermore, client method `GetCtrlState` may be used to query the current status.

Bus States can be:
* `ControllerState_CAN_OK` - CAN controller is "Error Active"
* `ControllerState_CAN_ERROR_PASSIVE` - CAN controller is "Error Passive"
* `ControllerState_CAN_BUS_OFF` - CAN controller is bus off

 {% if inclue.listenonly == "false" %}
#### Sending CAN Data

To send CAN data, prepare a batch of frames to be sent and call `SendFrames`.

```go
    // prepare batch of 10 frames
    frames := []*fspb.Frame{}

    for j := 0; j < 10; j++ {
      f := &fspb.Frame{
        MessageId:           uint32(0x100 + (i & 0xFF)),
        Data:                []byte{},
        ExtendedFrameFormat: *extended,
        RemoteFrame:         *rtr,
      }
      len := j % 8
      for k := 0; k < len; k++ {
        f.Data = append(f.Data, byte(j))
      }
      frames = append(frames, f)
    }
    // send frames at once
    err = c.SendFrames(frames)

    if err != nil {
      log.Printf("Send failed: %v\n", err)
    }

```
If you want a high send throughput, it is important *not* to call `SendFrames` with only a single frame. If you do so, overhead of the transmission to the io4edge will reduce your send bandwidth.

The maximum number of frames you can send with one batch is `31`.

You can't send frames and `SendFrames` will return an error in the following scenarios (status codes for go can be found [here](https://github.com/ci4rail/io4edge_api/blob/main/io4edge/go/functionblock/v1alpha1/io4edge_functionblock.pb.go))

| Condition                       | Error Code              |
| ------------------------------- | ----------------------- |
| No CANbus Configuration applied | UNSPECIFIC_ERROR        |
| Configured for listen only mode | UNSPECIFIC_ERROR        |
| Firmware Update in progress     | TEMPORARILY_UNAVAILABLE |
| Transmit buffer full            | TEMPORARILY_UNAVAILABLE |
| CANBus State is BUS OFF         | HW_FAULT                |

In case the firmware's transmit buffer is full, the firmware will send *none* of the frames and return TEMPORARILY_UNAVAILABLE error. Therefore you can retry later with the same set of frames.
{% endif %}

#### Bus Off Handling

When the CAN controller detects serious communication problems, it enters "Bus off" state. In this state, the CAN controller cannot communicate anymore with the bus.

When bus off state is entered, The firmware waits 3 seconds and then resets the CAN controller.

##### Multiple Clients

It is possible to have multiple clients active at the same time. For example:
{% if inclue.listenonly == "false" %}One client sends data, a second {% else %}One {%endif %} client receiving a stream with a specific filter and a another client receiving a stream with a different filter.


### Using SocketCAN

In Linux, [SocketCAN](https://www.kernel.org/doc/html/latest/networking/can.html) is the default framework to access the CANBus from applications.

The {{ page.product_name }} can be integrated into SocketCAN using the `socketcan-io4edge` gateway:

![{{ page.product_name }} product view]({{ '/user-docs/images/edge-solutions/io4edge/socketcan-io4edge.svg' | relative_url }}){: style="width: 80%"}

**NOTE:** When using SocketCAN, you must configure the CAN Controller persistently as shown here {{ page.product_name }}, as described [here]({{ link_to_static_busconfiguration }}).
{: .notice--warning}

In Ci4Rail Linux Images, the `socketcan-io4edge` gateway is started automatically by `socketcan-io4edge-runner` which detects available io4edge devices with CAN support and start an instance of the `socketcan-io4edge` gateway, if the corresponding virtual can instance exists. For an example, see [here]({{ link_to_socketcan_qs }}).
