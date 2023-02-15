### Features

* Delta-Sigma Converter with 300Hz to 4000Hz sampling frequency
  * up to 1500Hz: with guaranteed timing jitter less than 150µs
  * above 1500Hz: possible higher jitter and sporadic drop of samples
* Resolution depends on the sampling frequency
  * 15 bit @300Hz
  * 13 bit @1000Hz
  * 11.5 bit @2000Hz
  *  8.8 bit @4000Hz
* Accuracy: Better than 0.5% to full scale @300Hz sampling rate
* Voltage or current measurement
  * Voltage measurement range +/-10V. Input impedance 100kOhms/1nF.
  * Current measurement range +/-20mA. Impedance 50Ohms.
* Each analog input is completely isolated
* Integrated power supply for sensor: 24V, up to 24mA


### Connection

Each analog I/O group has its own connector:

![Analog Connector]({{ '/user-docs/images/edge-solutions/moducop/io-modules/analogintypea/conn.svg' | relative_url }})

| Pin | Symbol | Description          |
| --- | ------ | -------------------- |
| 1   | +24V   | Sensor supply output |
| 2   | Uin    | Voltage Input        |
| 3   | Iin    | Current Input        |
| 4   | 0V     | Measurement Ground   |

{% include content/io4edge/iou01-front/mating-connectors.md %}

### Aliasing Considerations

Note that the {{ page.product_name }} analog inputs do not have anti-aliasing filters. This means that the input signal must be sampled at a rate that is at least twice the highest frequency component of the signal. For example, if the input signal has a 1kHz sine wave, the sampling rate must be at least 2kHz. If the sampling rate is too low, the input signal will be aliased, and the output will be distorted.

Or in other words, your signal must not have frequency components higher than half of the sampling frequency.


### Using the io4edge API to access the Analog Inputs

{% include content/io4edge/functionblock/install-client.md example_name="analogInTypeA" %}

#### Connect to the Analog Input function

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
To access the Analog Inputs, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ page.example_device_name }}-analogInTypeA1`
* As an IP/Port: `192.168.201.1:10000`

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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
To access the analog inputs, create a *Client* and save it to the variable `ana_client`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `{{ page.example_device_name }}-{{ example_service_ext }}`
* As an IP/Port: `192.168.201.1:10000`

We need this client variable for all further access methods.

```python

import io4edge_client.analogintypea as ana
import io4edge_client.functionblock as fb

def main():
  ana_client = ana.Client(args.addr)
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Set the Sampling Rate
The sample rate is by default set to 300Hz. To change it to a higher value, use

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
  // set sampleRate to 1000 Hz
  if err := c.UploadConfiguration(anain.WithSampleRate(uint32(1000))); err != nil {
    log.Fatalf("Failed to set configuration: %v\n", err)
  }
```

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    # configure the function block
    config = ana.Pb.ConfigurationSet(sample_rate=1000)
    ana_client.upload_configuration(config)
```

<!--- PYTHON END --->
{% include content/tabv2/end.md %}
This setting remains active until you change it again or restart the device.


#### Reading Input Value {#readinputvalue}

To read the current value of the analog input:
{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
  val, err := c.Value()
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    val = ana_client.value()
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

Where `val` is a floating point number reflecting the current value, from -1.0..+1.0, corresponding to the full scale.

For voltage measurement, a value of `-1.0` corresponds to -10V, and `+1.0` corresponds to +10V.

For current measurement, a value of `-1.0` corresponds to -20mA, and `+1.0` corresponds to +20mA.

Note that the value is updated internally with the configured sample rate. If high accuracy is required, set the sample rate to the lowest sample rate (300Hz).

#### Streamed Sampling

In data logger applications, you may want to record the waveform on the analog input.

Therefore, the API provides functions to start a *Stream*.

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
```go
// start stream
err = c.StartStream()
```
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
{% capture example_all_options_py %}
```python
    # start stream
    ana_client.start_stream(
        fb.Pb.StreamControlStart(
            bucketSamples=100,
            keepaliveInterval=1000,
            bufferedSamples=200,
            low_latency_mode=False,
        ),
    )
```
{% endcapture %}
{{ example_all_options_py }}
<!--- PYTHON END --->
{% include content/tabv2/end.md %}

Then, *Samples* are generated with the configured sample rate in the stream, each sample contains:
* A timestamp of the sample
* Measured value

For efficiency, multiple samples are gathered are sent as one *Bucket* to the host.
To read samples from the stream:

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
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
<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
```python
    n = 0
    while True:
        generic_stream_data, stream_data = ana_client.read_stream()
        print(
            f"Received stream data {generic_stream_data.deliveryTimestampUs}, {generic_stream_data.sequence}"
        )
        for sample in stream_data.samples:
            print(" #%d: ts=%d %.4f" % (n, sample.timestamp, sample.value))
            n += 1
```
<!--- PYTHON END --->
{% include content/tabv2/end.md %}
`sample.Value` is as described in [the section above](#readinputvalue)

{% include content/io4edge/functionblock/timestamp.md %}


#### Controlling the Stream

{% include content/tabv2/start.md tabs="go, python" %}
<!--- GO START --->
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

{% include content/io4edge/functionblock/stream-common-go.md example_all_options=example_all_options describe_low_latency=false %}

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
{% include content/io4edge/functionblock/stream-common-python.md example_all_options=example_all_options_py describe_low_latency=false %}

<!--- PYTHON END --->
{% include content/tabv2/end.md %}

#### Multiple Clients

It is possible to have multiple clients active at the same time. For example:
One client reads the current value of the analog channel, another client reads the stream

Note that all clients use the same sampling rate on a particular analog channel.
