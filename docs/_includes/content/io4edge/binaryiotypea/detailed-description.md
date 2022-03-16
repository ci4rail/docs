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

### Use Cases

TODO

### Using the io4edge API to access the Binary I/Os

#### Connect to the binary I/O function

To access the Binary I/Os, create a *Client* `c`. Pass as address either a service address or an ip address with port. Examples:
* As a service address: `S101-IUO01-USB-EXT-1-binaryIoTypeA`
* As a IP/Port: `192.168.201.1:10000`

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
