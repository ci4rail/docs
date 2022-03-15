In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary I/Os and to read values from the analog inputs.

## Binary I/O Demo

The Binary I/O demo will stimulate the binary outputs of the {{ page.product_name }} one after another. Please supply the binary I/O groups with 24V, so when the output switch turns on, the binary I/O pin has 24V, which in turn illuminates the corresponding LED.

You will see a running light on the 4 LEDs.

### Connecting

Plug a mating connector to the two top connectors of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `CI` and `CO` pins to an external power supply delivering a voltage between 24V and 110V.

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-binio.svg' | relative_url }})

### Run Demo

The demo is provided as a docker container that is in a docker repository on the internet. Ensure that your target machine has internet connection.

- [Connect Moducop to internet]({{ '/edge-solutions/moducop/quick-start-guide/connect-to-internet' | relative_url }})

- [Login into Moducop Shell]({{ '/edge-solutions/moducop/quick-start-guide/connect-to-terminal' | relative_url }})

```bash
docker run --it --cmd binaryiotypea/blinky ci4rail/io4edge-demo
```

TODO: Expected output
