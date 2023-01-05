### Features

* Delta-Sigma Converter with 300Hz to 4000Hz sampling frequency
* Resolution depends on the sampling frequency
  * 15 bit @300Hz
  * 13 bit @1000Hz
  * 12 bit @2000Hz
  * 10.5 bit @4000Hz
* Accuracy: Better than 0.5% to full scale
* Voltage or current measurement
  * Voltage measurement range +/-10V. Input impedance 100kOhms/1nF.
  * Current measurement range +/-20mA. Impedance 50Ohms.
* Each analog input is completely isolated
* Integrated power supply for sensor: 24V, up to 24mA


### Connection

Each analogue I/O group has its own connector:

![Binary I/O Groups Pricnciple]({{ '/user-docs/images/edge-solutions/moducop/io-modules/analogintypea/conn.svg' | relative_url }})

| Pin | Symbol | Description          |
| --- | ------ | -------------------- |
| 1   | +24V   | Sensor supply output |
| 2   | Uin    | Voltage Input        |
| 3   | Iin    | Current Input        |
| 4   | 0V     | Measurement Ground   |

{% include content/io4edge/iou01-front/mating-connectors.md %}

### Using the io4edge API to access the Analog Inputs

If you haven't installed yet the io4edge client software, install it now as [described here]({{ page.url | append: "../quick-start-guide" | relative_url }}#getdemosoftware).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-go/tree/main/examples/analogInTypeA)

#### Connect to the Analog Input function

To access the Analog Inputs, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ page.example_device_name }}-analogInTypeA1`
* As a IP/Port: `192.168.201.1:10000`

We need this client variable for all further access methods.

```go
import (
  time
  log "github.com/sirupsen/logrus"

  anain "github.com/ci4rail/io4edge-client-go/analogintypea"
  "github.com/ci4rail/io4edge-client-go/functionblock"
)

func main() {
    c, err := anain.NewClientFromUniversalAddress("S101-IUO01-USB-EXT-1-analogInTypeA1", time.Second)
    if err != nil {
        log.Fatalf("Failed to create anain client: %v\n", err)
    }
}
```

### Set the Sampling Rate

The sample rate is by default set to 300Hz. To change it to a higher value, use

```go
  // set sampleRate to 1000 Hz
  if err := c.UploadConfiguration(anain.WithSampleRate(uint32(1000))); err != nil {
    log.Fatalf("Failed to set configuration: %v\n", err)
  }
```

This setting remains active until you change it again or restart the device.

### Reading Input Value {#readinputvalue}

To read the current value of the analog input:

```go
  val, err := c.Value()
```

Where `val` is a floating point number reflecting the current value, from -1.0..+1.0, corresponding to the full scale.

For voltage measurement, a value of `-1.0` corresponds to -10V, and `+1.0` corresponds to +10V.

For current measurement, a value of `-1.0` corresponds to -20mA, and `+1.0` corresponds to +20mA.

Note that the value is updated internally with the configured sample rate. If high accuracy is required, set the sample rate to the lowest sample rate (300Hz).

### Streamed Sampling

In data logger applications, you may want to record the waveform on the analog input.

Therefore the API provides functions to start a *Stream*.

```go
// start stream
err = c.StartStream()
```

Then, *Samples* are generated with the configured sample rate in the stream, each sample contains:
* A timestamp of the sample
* Measured value

For efficiency, multiple samples are gathered are sent as one *Bucket* to the host.
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
        fmt.Printf("  #%d: ts=%d %.4f\n", i, sample.Timestamp, sample.Value)
      }
    }
  }
```
`sample.Value` is as described in [the section above](#readinputvalue)


{% include content/io4edge/functionblock/timestamp.md %}

#### Controlling the Stream

{% capture example_keep_alive %}
```go
  // configure stream to send the bucket at least once a second
  err = c.StartStream(
    functionblock.WithKeepAliveInterval(1000),
  )
```
{% endcapture %}

{% capture example_all_options %}

```go
  // configure stream to send the bucket at least once a second
  // configure the samples per bucket to 100
  // configure the buffered samples to 200
  err = c.StartStream(
    functionblock.WithKeepAliveInterval(1000),
    functionblock.WithBucketSamples(100),
    functionblock.WithBufferedSamples(200),
  )
```
{% endcapture %}

{% include content/io4edge/functionblock/stream-common-go.md example_keep_alive=example_keep_alive example_all_options=example_all_options describe_low_latency=false %}


#### Multiple Clients

It is possible to have multiple clients active at the same time. For example:
One client reads the current value of the analog channel, another client reads the stream

Note that all clients use the same sampling rate on a particular analog channel.
