In this quick-start guide we will run demo programs to stimulate the {{ page.product_name }}'s binary I/Os and to read values from the analog inputs.

## Prerequisites

### Hardware
* A Moducop Edge Computer with a {{ page.product_name }} installed
* A Laboratory Power Supply capable of supplying 5V..24V/200mA.

{% include content/io4edge/go-examples-prerequisites.md %}

## Binary I/O Demo

The Binary I/O demo will stimulate the binary outputs of the {{ page.product_name }} one after another. Please supply the binary I/O groups with 24V, so when the output switch turns on, the binary I/O pin has 24V, which in turn illuminates the corresponding LED.

You will see a running light on the 4 LEDs.

### Connecting

Plug a mating connector to the two top connectors of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `CI` and `CO` pins to your laboratory power supply which is set to a voltage of 24V (up to 110V).

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-binio.svg' | relative_url }})

### Demo Software

{% include content/io4edge/iou-go-example.md example_name='blinky' example_path='binaryIoTypeA' %}

You should see now the 4 LEDs of the binary I/O running.
TODO: Video?

## Analog Input Demo

The Analog Input demo will sample one analog input of the {{ page.product_name }} for 10 seconds, with the sample rate you specify on the command line. The sampled values are printed.

### Connecting

Plug a mating connector to the 3rd connectors from the top of the {{ page.product_name }}.

{% include content/io4edge/iou01-front/mating-connectors.md %}

Connect the `CI` and `CO` pins to your laboratory power supply which is set to a voltage of 24V (up to 110V).

![Connection for Binary I/O Demo]({{ '/user-docs/images/edge-solutions/moducop/io-modules/iou01/iou01-qs-binio.svg' | relative_url }})

### Demo Software

{% include content/io4edge/iou-go-example.md example_name='blinky' example_path='binaryIoTypeA' %}

You should see now the 4 LEDs of the binary I/O running.
TODO: Video?
