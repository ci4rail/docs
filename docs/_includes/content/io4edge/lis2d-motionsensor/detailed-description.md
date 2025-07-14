{% assign example_service_name = page.example_device_name | append: "-accel" %}
### Features

The {{ page.product_name }} has a LIS2D motion sensor function block to capture accelerometer data and provide it as a stream of samples to the host application.

The device is always operated in high performance mode (focus on low noise), supporting 14 bit resolution of the sampled data.

Note that the LIS2D sensor is a 3-axis accelerometer, so the data stream contains samples for all three axes (X, Y, Z). It has no gyroscope functionality, so it does not provide angular velocity data.

Configurable parameters are:
* Sample rate: 12.5 Hz to 1600 Hz
* Full scale range: 2g to 16g
* Filter band width
* Select high pass or low pass path

Not supported:
* Temperature sensor
* Orientation functions
* Free-fall detection
* Tap detection


### Functional Description

After configuration and starting the stream, the device will continuously sample the accelerometer data and send it to the host application. The data is sent as a stream of samples, where each sample contains the timestamp, X, Y, and Z values of the accelerometer.

Note that X, Y, Z values are provided in the same coordinate system as the LIS2D accelerometer is mounted. The application may need to account for the device's orientation when interpreting the data.

X, Y, Z values are provided as float values in g (acceleration due to gravity). The values are scaled according to the configured full scale range. For example, if the full scale range is set to 2g, the values will be in the range of -2g to +2g.


### Using the io4edge API to access the Motion Sensor Function

There is currently no python client for the MotionSensor function block. The following code is for the Go client only.

{% include content/io4edge/functionblock/install-client.md example_name="motionSensor" %}

#### Connect to the Motion Sensor Function

{% include content/tabv2/start.md tabs="go"%}
<!--- GO START --->
To access the Motion Sensor Function, create a *Client* and save it to the variable `c`. Pass as address either a service address or an ip address with port. Example:
* As a service address: `{{ example_service_name }}`
* As an IP/Port: e.g. `192.168.200.1:10001`

We need this client variable for all further access methods.

```go
import (
	"fmt"
	"os"
	"time"
	"log"
	"github.com/ci4rail/io4edge-client-go/functionblock"
	"github.com/ci4rail/io4edge-client-go/motionsensor"
)

func main() {
	const timeout = 0 // use default timeout

	c, err := canl2.NewClientFromUniversalAddress("{{ example_service_name }}", timeout)
	if err != nil {
		log.Fatalf("Failed to create client: %v\n", err)
	}
```
<!--- GO END --->
{% include content/tabv2/end.md %}

#### Configure the Motion Sensor Function

Configuration parameters are:
* Sample Rate: 12.5 Hz, 25 Hz, 50 Hz, 100 Hz, 200 Hz, 400 Hz, 800 Hz, 1600 Hz
* Full Scale: 2g, 4g, 8g, 16g
* High Pass Filter: On/Off
* Bandwidth Ratio: 2, 4, 10, 20

Meaning of high pass filter and bandwidth ratio:
* If High Pass Filter is enabled, the sensor will filter out low frequencies and only pass high frequency signals. The cut off frequency is sample rate / bandwidth ratio.
* If High Pass Filter is disabled, the sensor will filter out high frequencies. The cut off frequency is sample rate / bandwidth ratio.

{% include content/tabv2/start.md tabs="go"%}

```go
	// set configuration
	if err := c.UploadConfiguration(
		motionsensor.WithSampleRate(12.5*1000.0),  // in milli Hertz
		motionsensor.WithFullScale(2.0),
		motionsensor.WithHighPassFilterEnable(true),
		motionsensor.WithBandWidthRatio(2)); err != nil {
		log.Fatalf("Failed to set configuration: %v\n", err)
	}
```
<!--- GO END --->
{% include content/tabv2/end.md %}

##### Start a Stream
To receive telegrams from the Motion Sensor, the API provides functions to start a *Stream*.

{% include content/io4edge/functionblock/stream-common-go.md example_all_options="" describe_low_latency=false %}

{% include content/tabv2/start.md tabs="go" %}
<!--- GO START --->

```go
	// start stream
	err = c.StartStream(
		functionblock.WithBucketSamples(10),
		functionblock.WithBufferedSamples(200),
		functionblock.WithLowLatencyMode(*lowLatency),
	)
	if err != nil {
		log.Fatalf("StartStream failed: %v\n", err)
	}
```
<!--- GO END --->

{% include content/tabv2/end.md %}


##### Receive Telegrams

In the stream the firmware generates *Buckets*, where each Bucket contains a number of Samples.

To read samples from the stream:

{% include content/tabv2/start.md tabs="go" %}
<!--- GO START --->

```go
	...
	prevTs := uint64(0)
	for {
		// read next bucket from stream
		sd, err := c.ReadStream(time.Second * 1)

		if err != nil {
			fmt.Printf("ReadStreamData failed: %v\n", err)
		} else {
			samples := sd.FSData.GetSamples()
			fmt.Printf("got stream data seq=%d with %d samples\n", sd.Sequence, len(samples))

			for _, sample := range samples {
			nSamples++
			record := []string{
				fmt.Sprintf("%d", sample.Timestamp),
				fmt.Sprintf("%.6f", sample.X),
				fmt.Sprintf("%.6f", sample.Y),
				fmt.Sprintf("%.6f", sample.Z),
			}

			fmt.Printf("t: %15d dt: %7d x: %.6f, y: %.6f, z: %.6f\n",
				sample.Timestamp, sample.Timestamp-prevTs, sample.X, sample.Y, sample.Z)

			prevTs = sample.Timestamp
			}
		}
	}
```
<!--- GO END --->
{% include content/tabv2/end.md %}
{% include content/io4edge/functionblock/timestamp.md %}
