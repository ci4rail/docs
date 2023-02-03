<!---
Pass the following parameters in the include directive:
- example_all_options - code snippet for all options
- describe_low_latency - true/false
--->


The stream behavior can be fine-tuned to the application needs. If you do not specify any parameters, the default values are used.

* The `BucketSamples` parameter (default: `25`) defines the number of samples per bucket. If the bucket contains `BucketSamples`, it is sent to the client.

* The `KeepAliveInterval` parameter (default: `1000`) defines the maximum time in ms between two buckets. If the bucket is not full, it is sent after the configured interval.

* The `BufferedSamples` parameter (default: `50`) defines the number of samples that can be buffered in the device. If the buffer is full, the oldest samples are overwritten. As a rule of thumb, `BufferedSamples` should be at least two times the `BucketSamples`. Select a higher number if your reception process is slow to avoid buffer overruns.

{% if include.describe_low_latency %}
* If you want low latency on the received data, you can enable the "low latency" mode by using `LowLatencyMode` (default: `false`). In this mode, samples are sent as soon as possible after they have been received. This means that the buckets contain `1..BufferedSamples` samples.
{% endif %}

{{ include.example_all_options }}
