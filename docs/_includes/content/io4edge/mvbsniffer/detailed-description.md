<!---
Pass the following parameters in the include directive:
- link_to_getdemosoftware
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
* Can capture up to 20000 MVB telegrams per second
* Built-in MVB frame generator for internal self test


### Connection

The MVB sniffer has two 9-pin D-Sub connectors, internally connected 1:1 with the following pinout. One connector is a plug, the second is a socket. The pinout is compliant with the MVB standard IEC61375-3-1.


| Pin | Symbol    | Description                                                               |
| --- | --------- | ------------------------------------------------------------------------- |
| 1   | A.Data_P  | positive wire Line_A                                                      |
| 2   | A.Data_N  | negative wire Line_A                                                      |
| 3   | TXE       | not connected to the MVB Sniffer / just passed through to other connector |
| 4   | B.Data_P  | positive wire Line_B                                                      |
| 5   | B.Data_N  | negative wire Line_B                                                      |
| 6   | A.Bus_GND | not connected to the MVB Sniffer / just passed through to other connector |
| 7   | B.Bus_GND | not connected to the MVB Sniffer / just passed through to other connector |
| 8   | A.Bus_5V  | not connected to the MVB Sniffer / just passed through to other connector |
| 9   | B.Bus_5V  | not connected to the MVB Sniffer / just passed through to other connector |


**WARNING:** If the gender of your MVB cables don't match to the {{ page.product_name }}'s connectors, don't use gender changers! Most gender changers will swap pins, so that Line_A and Line_B and the polarities are swapped. This will lead to a non-working MVB Sniffer and/or non-working bus!
{: .notice--warning}

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

{% include content/io4edge/functionblock/install-client.md example_name="mvbSniffer" %}

#### Connect to the MVB Sniffer Function

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
To access the MVB Sniffer Function, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ example_service_name }}`
* As an IP/Port: e.g. `192.168.201.1:10000`

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

  c, err := canl2.NewClientFromUniversalAddress("{{ example_service_name }}", timeout)
  if err != nil {
    log.Fatalf("Failed to create client: %v\n", err)
  }
}
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
To access the MVB Sniffer Function, create a *Client* and save it to the variable `mvb_client`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ example_service_name }}`
* As an IP/Port: `192.168.201.1:10000`

We need this client variable for all further access methods.

```python
import io4edge_client.mvbsniffer as mvb
import io4edge_client.functionblock as fb

def main():
  mvb_client = mvb.Client(address)
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Receiving MVB Telegrams

##### Start a Stream
To receive telegrams from the MVB, the API provides functions to start a *Stream*. When starting the stream, you can specify a filter to receive only telegrams that match the filter criteria.

The following code shows a typical filter setting: Receive all frames with all FCodes, but no timed out frames.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->

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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    stream_start = mvb.Pb.StreamControlStart()
    stream_start.filter.add(f_code_mask=0x0FFF, include_timedout_frames=False)

    mvb_client.start_stream(
        stream_start,
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=False,
        ),
    )
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

The filter algorithm for MVB addresses is `pass_filter = (Address & Mask) == (Received_Address & Mask)`.

The filter algorithm for FCode is `pass_filter = (FCodeMask & (1<<Received_FCode)) != 0`.

You can combine up to 4 filters in one stream. If a telegram matches any filter, it is passed to the stream. This example defines two filters:

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
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
      // receive only FCode 15 telegrams with address 0x01xx
      FCodeMask:             0x8000,  // matches FCode 15
      Address:               0x0100,  // matches addresses 0x01xx
      Mask:                  0xFF00,
      IncludeTimedoutFrames: false,
    }),
    mvbsniffer.WithFBStreamOption(functionblock.WithBucketSamples(100)),
    mvbsniffer.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    stream_start = mvb.Pb.StreamControlStart()
    # receive only process data telegram, at any address
    stream_start.filter.add(
      f_code_mask=0x001F,
      address=0x0000,
      mask=0x0000,
      include_timedout_frames=False
    )
    # receive only FCode 15 telegrams with address 0x01xx
    stream_start.filter.add(
      f_code_mask=0x8000,
      address=0x0100,
      mask=0xFF00,
      include_timedout_frames=False
    )

    mvb_client.start_stream(
        stream_start,
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=False,
        ),
    )
```

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

##### Receive Telegrams

In the stream the firmware generates *Buckets*, where each Bucket contains a number of *Telegrams*. Each Telegram contains timestamp, FCode, MVB address, and data. Details can be found in the [API protobuf definition](https://github.com/ci4rail/io4edge_api/blob/main/mvbSniffer/proto/mvbSniffer/v1/telegram.proto).


To read samples from the stream:

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    while True:
        try:
            generic_stream_data, telegrams = mvb_client.read_stream(timeout=3)
        except TimeoutError:
            print("Timeout while reading stream")
            continue

        print(
            "Received %d telegrams, seq=%d"
            % (len(telegrams.entry), generic_stream_data.sequence)
        )
        for telegram in telegrams.entry:
            if telegram.state != mvb.TelegramPb.Telegram.State.kSuccessful:
                if telegram.state & mvb.TelegramPb.Telegram.State.kTimedOut:
                    print("No slave frame has been received to a master frame")
                if telegram.state & mvb.TelegramPb.Telegram.State.kMissedMVBFrames:
                    print(
                        "one or more MVB frames are lost in the device since the last telegram"
                    )
                if telegram.State & mvb.TelegramPb.Telegram.State.kMissedMVBFrames:
                    print("one or more telegrams are lost")
            print(telegram_to_str(telegram))


def telegram_to_str(telegram):
    ret_val = "addr=%03x, " % telegram.address
    ret_val += "%s" % mvb.TelegramPb._TELEGRAM_TYPE.values_by_number[telegram.type].name
    if len(telegram.data) > 0:
        ret_val += ", data="
        for b in telegram.data:
            ret_val += "%02x " % b
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
  // configure the maximum samples per bucket to 100
  // configure low latency mode
  // configure the buffered samples to 200
  err = c.StartStream(
      mvbsniffer.WithFBStreamOption(functionblock.WithKeepaliveInterval(1000)),
      mvbsniffer.WithFBStreamOption(functionblock.WithBucketSamples(100)),
      mvbsniffer.WithFBStreamOption(functionblock.WithLowLatencyMode(true))
      mvbsniffer.WithFBStreamOption(functionblock.WithBufferedSamples(200)),
  )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-go.md example_all_options=example_all_options describe_low_latency=false %}

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->

{% capture example_all_options %}
```python
    stream_start = mvb.Pb.StreamControlStart()
    stream_start.filter.add(f_code_mask=0x0FFF, include_timedout_frames=False)

    mvb_client.start_stream(
        stream_start,
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=False,
        ),
    )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-python.md example_all_options=example_all_options describe_low_latency=false %}

<!--- PYTHON END --->
