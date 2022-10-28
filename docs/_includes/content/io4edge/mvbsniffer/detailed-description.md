<!---
Pass the following parameters in the include directive:
--->
{% assign example_service_name = page.example_device_name | append: "-mvbSniffer" %}
### Features

The {{ page.product_name }} has a MVB sniffer function block to capture MVB frames on the MVB bus and provide them as a stream of telegrams to the host application. A telegram is the combination of the master frame with the corresponding answer from the slave.

The MVB sniffer operates listen-only, i.e. can only read from the bus, it cannot send any data, simply because the hardware has no transmitter.
Furthermore, the receiver is coupled through a high impedance circuit to the bus, therefore the MVB sniffer cannot influence the bus operation.

Features:
* MVB ESD and EMD support
* Timestamping of received data with microsecond resolution
* Capturing of all MVB frame types (FCodes)
* Per stream filtering of MVB frames by address and FCode
* Can capture up to 20000 MVB frames per second
* Built-in MVB frame generator for internal self test


### Connection

The MVB sniffer has two 9-pin D-Sub connectors, internally connected 1:1 with the following pinout. One connector is a plug, the second is a socket.


| Pin | Symbol    | Description                                       |
| --- | --------- | ------------------------------------------------- |
| 1   | A.Data_P  | positive wire Line_A                              |
| 2   | A.Data_N  | negative wire Line_A                              |
| 3   | TXE       | not used / just passed through to other connector |
| 4   | B.Data_P  | positive wire Line_B                              |
| 5   | B.Data_N  | negative wire Line_B                              |
| 6   | A.Bus_GND | not used / just passed through to other connector |
| 7   | B.Bus_GND | not used / just passed through to other connector |
| 8   | A.Bus_5V  | not used / just passed through to other connector |
| 9   | B.Bus_5V  | not used / just passed through to other connector |


### Functional Description

The MVB sniffer firmware permanently captures all frames from both lines of the MVB. Redundant frames are discarded (only one frame of the two redunant frames is used).

The MVB sniffer combines a master frame and a corresponding slave response into a *Telegram*, so the application receives the timestamp, MVB address, FCode and Data in a single object.

All types of FCodes are supported, but MVB Message Data re-assembly has to be done by the application.

When a host application starts a stream, it tells the MVB sniffer which types of telegrams it wants to receive. Application can define four filters per stream, each filter can specify a MVB address range, FCode mask and whether to receive timed out frames. The MVB sniffer will only send telegrams to the host application that match the filter criteria.

Multiple applications may be connected simultaneously to the same MVB sniffer, each application can use a different filter.

#### Handling of Erroneous MVB Frames

* MVB frames with CRC errors are discarded
* MVB slave frames without a master frame before are discarded
* MVB slave frames that arrive too late may or may not be discarded, depending on the application's filter settings

### Using the io4edge API to access the MVB Sniffer

If you haven't installed yet the io4edge client software, install it now as [described here]({{ page.url | append: "../quick-start-can-io4edge" | relative_url }}#getdemosoftware).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-go/tree/main/examples/mvbSniffer)

#### Connect to the MVB Sniffer Function

To access the MVB Sniffer Function, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ example_service_name }}`
* As a IP/Port: e.g. `192.168.201.1:10000`

We need this client variable for all further access methods.

```go
import (
  "fmt"
  "os"
  "time"

  "log"

  "github.com/ci4rail/io4edge-client-go/functionblock"
  "github.com/ci4rail/io4edge-client-go/mvbsniffer"
  mvbpb "github.com/ci4rail/io4edge_api/mvbSniffer/go/mvbSniffer/v1"
)

func main() {
  const timeout = 0 // use default timeout

  c, err := canl2.NewClientFromUniversalAddress({{ example_service_name }}, timeout)
  if err != nil {
    log.Fatalf("Failed to create client: %v\n", err)
  }
}
```

#### Receiving MVB Telegrams

##### Start a Stream
To receive telegrams from the MVB, the API provides functions to start a *Stream*. When starting the stream, you can specify a filter to receive only telegrams that match the filter criteria.

The following code shows a typical filter setting: Receive all frames with all FCodes, but no timed out frames.

```go
  // start stream
  err = c.StartStream(
    mvbsniffer.WithFilterMask(mvbsniffer.FilterMask{
      // receive any telegram, except timed out frames
      FCodeMask:             0xFFFF,
      Address:               0x0000,
      Mask:                  0x0000,
      IncludeTimedoutFrames: false,
    }),
    mvbsniffer.WithFBStreamOption(functionblock.WithBucketSamples(100)),
    mvbsniffer.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
  if err != nil {
    log.Errorf("StartStream failed: %v\n", err)
  }
```

The filter algorithm for MVB addresses is `pass_filter = (Address & Mask) == (Received_Address & Mask)`.

The filter algorithm for FCode is `pass_filter = (FCodeMask & (1<<Received_FCode)) != 0`.

You can combine up to 4 filters in one stream. If a telegram matches any filter, it is passed to the stream. This example defines two filters:

```go
  // start stream
  err = c.StartStream(
    mvbsniffer.WithFilterMask(mvbsniffer.FilterMask{
      // receive only process data telegram, at any address
      FCodeMask:             0x001F,  // matches FCodes 0..4
      Address:               0x0000,
      Mask:                  0x0000,
      IncludeTimedoutFrames: false,
    }),
    mvbsniffer.WithFilterMask(mvbsniffer.FilterMask{
      // receive any telegram, except timed out frames
      FCodeMask:             0x8000,  // matches FCode 15
      Address:               0x0100,  // matches addresses 0x01xx
      Mask:                  0xFF00,
      IncludeTimedoutFrames: false,
    }),
    mvbsniffer.WithFBStreamOption(functionblock.WithBucketSamples(100)),
    mvbsniffer.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
```

##### Receive Telegrams

In the stream the firmware generates *Buckets*, where each Bucket contains a number of *Telegrams*. Each Telegram contains timestamp, FCode, MVB address, and data. Details can be found in the [API protobuf definition](https://github.com/ci4rail/io4edge_api/blob/main/mvbSniffer/proto/mvbSniffer/v1/telegram.proto).


To read samples from the stream:

```go
  ...
  prevTs := uint64(0)
  for {
    // read next bucket from stream
    sd, err := c.ReadStream(time.Second * 1)

    if err != nil {
      log.Errorf("ReadStreamData failed: %v\n", err)
    } else {
      telegramCollection := sd.FSData.GetEntry()

      for _, telegram := range telegramCollection {
        dt := uint64(0)
        if prevTs != 0 {
          dt = telegram.Timestamp - prevTs
        }
        prevTs = telegram.Timestamp

        if telegram.State != uint32(mvbpb.Telegram_kSuccessful) {
          if telegram.State&uint32(mvbpb.Telegram_kTimedOut) != 0 {
            log.Errorf("No slave frame has been received to a master frame\n")
          }
          if telegram.State&uint32(mvbpb.Telegram_kMissedMVBFrames) != 0 {
            log.Errorf("one or more MVB frames are lost in the device since the last telegram\n")
          }
          if telegram.State&uint32(mvbpb.Telegram_kMissedTelegrams) != 0 {
            log.Errorf("one or more telegrams are lost\n")
          }
        }

        fmt.Printf("dt=%d %s\n", dt, telegramToString(telegram))
      }
    }
  }
  ...

func telegramToString(t *mvbpb.Telegram) string {
  s := fmt.Sprintf("addr=%06x, ", t.Address)
  s += fmt.Sprintf("%s, ", mvbpb.Telegram_Type_name[int32(t.Type)])
  if len(t.Data) > 0 {
    s += "data="
    for i := 0; i < len(t.Data); i++ {
      s += fmt.Sprintf("%02x ", t.Data[i])
    }
  }
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
