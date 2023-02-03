
<!---
Pass the following parameters in the include directive:
- listenonly: "true" or "false"
- connector: the connector description
- link_to_static_busconfiguration
- link_to_socketcan_qs
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

{% include content/io4edge/functionblock/install-client.md example_name="canL2" %}

#### Connect to the CAN Function

{% include content/tabv2/start.md tabs="go, python" %}

<!--- GO START --->
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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
To access the binary I/Os, create a *Client* and save it to the variable `can_client`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ example_service_name }}`
* As an IP/Port: `192.168.201.1:10000`

We need this client variable for all further access methods.

```python
import io4edge_client.canl2 as canl2
import io4edge_client.functionblock as fb

def main():
  can_client = canl2.Client("{{ example_service_name }}")
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Bus Configuration

There are two ways to configure the CAN function:

* Using a persistent parameter that is stored in the flash of the {{ page.product_name }}, as described [here]({{ link_to_static_busconfiguration }}).
* Temporarily, via the io4edge CANL2 API, as shown below

##### Temporary Bus Configuration

When applying a configuration via the API, the configuration is only active until the next restart of the device. The configuration is not stored in flash. When the device is restarted, it will apply the persistent configuration stored in flash, or - if no persistent configuration is available - will keep the CAN controller disabled.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

Bus Configuration can be set via `UploadConfiguration`.

```go
  err = c.UploadConfiguration(
    canl2.WithBitRate(125000),
    canl2.WithSamplePoint(0.625),
    canl2.WithSJW(1),
    {% if include.listenonly == "false" %}canl2.WithListenOnly(false),{% else %}canl2.WithListenOnly(true),{% endif %}
  )
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
Bus Configuration can be set via `upload_configuration`.

Note: The sample point is given as a thousandth of a percent, e.g. 625 for 62.5%.

```python
    can_client.upload_configuration(
        canl2.Pb.ConfigurationSet(
            baud=125000,
            samplePoint=625,
            sjw=1,
            listenOnly={% if include.listenonly == "false" %}False{% else %}True{% endif %},
        )
    )
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}
#### Receiving CAN Data

To receive data from the CANbus, the API provides functions to start a *Stream*.

In the stream the firmware generates *Buckets*, where each Bucket contains a number of *Samples*. Each sample contains:
* A timestamp of the sample
* The CAN frame (may be missing in case of bus state changes or error events)
* The CAN Bus state (Ok, error passive or bus off)
* Error events (currently: receive buffer overruns)

For efficiency, multiple samples are gathered are sent as one *Bucket* to the host.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    # start stream, accept all frames
    stream_start = canl2.Pb.StreamControlStart(
        acceptanceCode=0, acceptanceMask=0
    )

    can_client.start_stream(
        stream_start,
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=False,
        ),
    )

    while True:
        try:
            generic_stream_data, stream_data = can_client.read_stream(timeout=3)
        except TimeoutError:
            print("Timeout while reading stream")
            continue

        print(
            "Received %d samples, seq=%d" % (len(stream_data.samples), generic_stream_data.sequence)
        )

        for sample in stream_data.samples:
            print(sample_to_str(sample))


def sample_to_str(sample):
    ret_val = "%10d us: " % sample.timestamp
    if sample.isDataFrame:
        frame = sample.frame
        ret_val += "ID:"
        if frame.extendedFrameFormat:
            ret_val += "%08X" % frame.messageId
        else:
            ret_val += "%03X" % frame.messageId
        if frame.remoteFrame:
            ret_val += " R"
        ret_val += " DATA:"
        for i in range(len(frame.data)):
            ret_val += "%02X " % frame.data[i]
        ret_val += " "

    ret_val += "ERROR: " + canl2.Pb._ERROREVENT.values_by_number[sample.error].name
    ret_val += (
        " STATE: "
        + canl2.Pb._CONTROLLERSTATE.values_by_number[sample.controllerState].name
    )
    return ret_val
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}
{% include content/io4edge/functionblock/timestamp.md %}


##### Controlling the Stream

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

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

{% include content/io4edge/functionblock/stream-common-go.md example_all_options=example_all_options describe_low_latency=true %}


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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
{% capture example_all_options %}

If you don't want to receive all CAN identifiers, you can specify an acceptance code and mask that is applied to each received frame. The filter algorithm is `pass_filter = (code & mask) == (received_frame_id & mask)`.
The same filter is applied to extended frames and standard frames.

```python
    # apply a filter. Frames with an identifier of 0x1xx pass the filter, other frames are filtered out
    stream_start = canl2.Pb.StreamControlStart(
        acceptanceCode=0x100, acceptanceMask=0x700
    )

    can_client.start_stream(
        stream_start,
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=args.lowlatency,
        ),
    )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-python.md example_all_options=example_all_options describe_low_latency=true %}
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

##### Error Indications and Bus State
The samples in the stream contain also error events and the current bus state.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
Error events can be:
* `ErrorEvent_CAN_NO_ERROR` - no event
* `ErrorEvent_CAN_RX_QUEUE_FULL` - either the CAN controller dropped a frame or the stream buffer was full

Each sample contains also the bus state. When the bus state changes, a sample without a CAN frame may be generated.
Furthermore, client method `GetCtrlState` may be used to query the current status.

Bus States can be:
* `ControllerState_CAN_OK` - CAN controller is "Error Active"
* `ControllerState_CAN_ERROR_PASSIVE` - CAN controller is "Error Passive"
* `ControllerState_CAN_BUS_OFF` - CAN controller is bus off

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
Error events can be:
* `canl2.Pb.ErrorEvent.CAN_NO_ERROR` - no event
* `canl2.Pb.ErrorEvent.CAN_RX_QUEUE_FULL` - either the CAN controller dropped a frame or the stream buffer was full

Each sample contains also the bus state. When the bus state changes, a sample without a CAN frame may be generated.
Furthermore, client method `ctrl_state` may be used to query the current status.

Bus States can be:
* `canl2.Pb.ControllerState.CAN_OK` - CAN controller is "Error Active"
* `canl2.Pb.ControllerState.CAN_ERROR_PASSIVE` - CAN controller is "Error Passive"
* `canl2.Pb.ControllerState.CAN_BUS_OFF` - CAN controller is bus off

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

{% if include.listenonly == "false" %}
#### Sending CAN Data
{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

To send CAN data, prepare a batch of frames to be sent and call `SendFrames`.

```go
    // prepare batch of 10 frames
    frames := []*fspb.Frame{}

    for j := 0; j < 10; j++ {
      f := &fspb.Frame{
        MessageId:           uint32(0x100),
        Data:                []byte{},
        ExtendedFrameFormat: false,
        RemoteFrame:         false,
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

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->

To send CAN data, prepare a batch of frames to be sent and call `send_frames`.

```python
  frames = []
  for msg in range(10):
      frames.append(
          canl2.Pb.Frame(
              messageId=0x100,
              data=bytes([msg for _ in range(msg % 8)]),
              extendedFrameFormat=False,
              remoteFrame=False,
          )
      )
  can_client.send_frames(frames)
```

If you want a high send throughput, it is important *not* to call `send_frames` with only a single frame. If you do so, overhead of the transmission to the io4edge will reduce your send bandwidth.

The maximum number of frames you can send with one batch is `31`.

You can't send frames and `send_frames` will return an error in the following scenarios)

<!--- PYTHON END --->
{% include content/tabv2/end.md %}


| Condition                       | Error Code              |
| ------------------------------- | ----------------------- |
| No CANbus Configuration applied | UNSPECIFIC_ERROR        |
| Configured for listen only mode | UNSPECIFIC_ERROR        |
| Firmware Update in progress     | TEMPORARILY_UNAVAILABLE |
| Transmit buffer full            | TEMPORARILY_UNAVAILABLE |
| CANBus State is BUS OFF         | HW_FAULT                |

In case the firmware's transmit buffer is full, the firmware will send *none* of the frames and return TEMPORARILY_UNAVAILABLE error. Therefore, you can retry later with the same set of frames.
{% endif %}

#### Bus Off Handling

When the CAN controller detects serious communication problems, it enters "Bus off" state. In this state, the CAN controller cannot communicate anymore with the bus.

When bus off state is entered, The firmware waits 3 seconds and then resets the CAN controller.

#### Multiple Clients

It is possible to have multiple clients active at the same time. For example:
{% if inclue.listenonly == "false" %}One client sends data, a second {% else %}One {%endif %} client receiving a stream with a specific filter and a another client receiving a stream with a different filter.


### Using SocketCAN

In Linux, [SocketCAN](https://www.kernel.org/doc/html/latest/networking/can.html) is the default framework to access the CANBus from applications.

The {{ page.product_name }} can be integrated into SocketCAN using the `socketcan-io4edge` gateway:

![{{ page.product_name }} product view]({{ '/user-docs/images/edge-solutions/io4edge/socketcan-io4edge.svg' | relative_url }}){: style="width: 80%"}

**NOTE:** When using SocketCAN, you must configure the CAN Controller persistently as shown here {{ page.product_name }}, as described [here]({{ link_to_static_busconfiguration }}).
{: .notice--warning}

In Ci4Rail Linux Images, the `socketcan-io4edge` gateway is started automatically by `socketcan-io4edge-runner` which detects available io4edge devices with CAN support and start an instance of the `socketcan-io4edge` gateway, if the corresponding virtual can instance exists. For an example, see [here]({{ link_to_socketcan_qs }}).
