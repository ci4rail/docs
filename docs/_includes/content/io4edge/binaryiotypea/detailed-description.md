### Function Principle

The {{ page.product_name }} has a Binary I/O function block with 4 channels, corresponding to 4 pins.
* 2 galvanically isolated groups, group1=Pin 1/2, group2=Pin 3/4
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


![Binary I/O Groups Pricnciple]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/groups-principle.svg' | relative_url }})

### Connection

Each binary I/O groups has its own connector:

![Binary I/O Groups Pricnciple]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/conn.svg' | relative_url }})

| Pin | Symbol | Description                                     |
| --- | ------ | ----------------------------------------------- |
| 1   | CO     | Common Voltage connected to the output switches |
| 2   | IO1/3  | First I/O pin of the group                      |
| 3   | IO2/4  | Second I/O pin of the group                     |
| 4   | CI     | Common Reference voltage for inputs             |

{% include content/io4edge/iou01-front/mating-connectors.md %}

### Use Cases

#### How to Connect the Load
Load may be connected to ground (high side switch) or to supply (low side switch).

![Connect Load]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-output1.svg' | relative_url }})

#### Using Inputs

In case you want to use a pin as input, you can select whether the input needs to be driven to high or low.
The switching threshold of the input is ~11V.

![Use Inputs]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-inputs.svg' | relative_url }})

#### Controlling a DC Motor

This example shows how you can control a DC Motor in both directions:

![DC Motor Application]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-motor.svg' | relative_url }})

#### Mixed Application

This example shows how you can use one pins of a group as input and the other pin as output. It also shows that you can supply each group with a different voltage:

![Mixed Application]({{ '/user-docs/images/edge-solutions/moducop/io-modules/binaryiotypea/use-case-mixed-voltage.svg' | relative_url }})


### Using the io4edge API to access the Binary I/Os

If you haven't installed yet the io4edge client software, install it now as [described here]({{ page.url | append: "../quick-start-guide" | relative_url }}#getdemosoftware).

#### Connect to the binary I/O function

To access the Binary I/Os, create a *Client* `c`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `S101-IUO01-USB-EXT-1-binaryIoTypeA`
* As a IP/Port: `192.168.201.1:10000`

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

###
