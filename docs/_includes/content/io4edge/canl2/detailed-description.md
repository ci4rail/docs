{% assign example_service_name = page.example_device_name | append: "-can" %}
### Features

* ISO 11898 CANBus Interface, up to 1MBit/s
* Usable for direct I/O or as data logger with multiple data streams.
* SocketCAN Support
* Standard and Extended Frame Support
* RTR Frame Support
* Optional Listen Only Mode
* One Acceptance Mask/Filter

### Connection

Connection is done via 9-pin DSub plug:

| Pin | Symbol  | Description                |
| --- | ------- | -------------------------- |
| 1   | -       | Not connected              |
| 2   | CAN_L   | CAN Signal (dominant low)  |
| 3   | GND_ISO | CAN Ground                 |
| 4   | -       | Not connected              |
| 5   | SHIELD  | Shield                     |
| 6   | GND_ISO | CAN Ground                 |
| 7   | CAN_H   | CAN Signal (dominant high) |
| 8   | -       | Not connected              |
| 9   | -       | Not connected              |


### Using the io4edge API to access CAN Function

If you haven't installed yet the io4edge client software, install it now as [described here]({{ page.url | append: "../quick-start-can-io4edge" | relative_url }}#getdemosoftware).

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

	c, err := canl2.NewClientFromUniversalAddress({{ example_service_name }}, timeout)
	if err != nil {
		log.Fatalf("Failed to create canl2 client: %v\n", err)
	}
}
```

#### Bus Configuration

There are two ways to configure the CAN function:

* Using a peristent parameter that is stored in the flash of the {{ page.product_name }}, as described [here]({{ page.url | append: "../quick-start-can-io4edge" | relative_url }}#busconfiguration).
* Temporarily, via the io4edge CANL2 API, as shown below

##### Temporary Bus Configuration

Bus Configuration can be set via `UploadConfiguration`. All settings remains active until you change it again or restart the device.

When the device is restarted, it will apply the persistent configuration stored in flash, or - if no persistent configuration is available, will keep the CAN controller disabled.

```go
	err = c.UploadConfiguration(
		canl2.WithBitRate(125000),
		canl2.WithSamplePoint(0.625),
		canl2.WithSJW(1),
		canl2.WithListenOnly(false),
	)
```

#### Receiving CAN Data

To receive data from the CANbus, the API provides functions to start a *Stream*.

Without any parameters, the stream receives all CAN frames:
```go
// start stream
err = c.StartStream()
```

Then, *Samples* are generated. Each sample contains:
* A timestamp of the sample
* The CAN frame (may be missing in case of bus state changes or error events)
* The CANBus state (Ok, error passive or bus off)
* Error events (currently: receive buffer overrungs)

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

**NOTE:** At the moment, timestamps are expressed in micro seconds relative to the start of the {{ page.product_name }}. Future client libraries will map the time to the host's time domain
{: .notice--warning}

##### Controlling the Stream

It is possible to fine-tune the stream behavior to the application needs:

Configure a keep alive interval, then you get a bucket latest after the configured interval, regardless whether the bucket is full or not:

```go
  // configure stream to send the bucket at least once a second
  err = c.StartStream(
    functionblock.WithKeepAliveInterval(1000),
  )
```

Configure the number of samples per bucket. By default, a bucket contains max. 25 samples. This means, the bucket is sent when at least 25 samples are available.

If you want low latency on the received data, you can change the number of samples per bucket to 1. Then the bucket is sent already with the first frame that arrives. However, subsequent buckets may contain more samples, if already more samples are in the internal buffer.

Furthermore, you can configure the number of buffered samples. Select a higher number if your receive process is slow to avoid buffer overruns.


```go
  // configure stream to send the bucket at least once a second
  // configure the samples per bucket to 1
  // configure the buffered samples to 200
  err = c.StartStream(
    functionblock.WithKeepAliveInterval(1000),
    functionblock.WithBucketSamples(1),
    functionblock.WithBufferedSamples(200),
  )
```

If you don't want to receive all CAN identifiers, you can specify an acceptance code and mask that is applied to each received frame. The filter algorithm is `pass_filter = (code & mask) == (received_frame_id & mask)`.
The same filter is applied to extended frames and standard frames.

```go
  // apply a filter. Frames with an identifier of 0x1xx pass the filter, other frames are filtered out
  err = c.StartStream(
    code := 0x100
    mask := 0x700
    canl2.WithFilter(code, mask),
  )
```

#### Error Indications and Bus State

TODO

### Sending CAN Data

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
If you want a high send throughput, it is important *not* to call `SendFrames` with only a single frame. If you do so, overhead of the transmission to the io4edge will reduce your send bandwith.

The maximum number of frames you can send with one batch is `31`.

You can't send frames and `SendFrames` will return an error in the following scenarios:

| Condition                       | Error Code              |
| ------------------------------- | ----------------------- |
| No CANbus Configuration applied | UNSPECIFIC_ERROR        |
| Configured for listen only mode | UNSPECIFIC_ERROR        |
| Firmware Update in progress     | TEMPORARILY_UNAVAILABLE |
| Transmit buffer full            | TEMPORARILY_UNAVAILABLE |
| CANBus State is BUS OFF         | HW_FAULT                |

In case the firmware's transmit buffer is full, the firmware will send *none* of the frames and return TEMPORARILY_UNAVAILABLE error. Therefore you can retry later with the same set of frames.

### Bus Off Handling

#### Multiple Clients

It is possible to have multiple clients active at the same time. For example:
One client reads the current value of the analog channel, another client reads the stream
