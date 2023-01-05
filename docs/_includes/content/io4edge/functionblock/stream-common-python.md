<!---
Pass the following parameters in the include directive:
- example_all_options - code snippet for all options
- describe_low_latency - true/false
--->

The stream behavior can be fine-tuned to the application needs:

* The `bucketSamples` parameter defines the number of samples per bucket. If the bucket contains `bucketSamples`, it is sent to the client.

* The `keepAliveInterval` parameter defines the maximum time between two buckets. If the bucket is not full, it is sent after the configured interval.

* The `bufferedSamples` parameter defines the number of samples that can be buffered in the device. If the buffer is full, the oldest samples are overwritten. As a rule of thumb, `bufferedSamples` should be at least two times the `bucketSamples`. Select a higher number if your reception process is slow to avoid buffer overruns.

{% if include.describe_low_latency %}
* If you want low latency on the received data, you can enable the "low latency" mode by setting `low_latency_mode` to `True`. In this mode, samples are sent as soon as possible after they have been received. This means that the buckets contain `1..bufferedSamples` samples.
{% endif %}

{{ include.example_all_options }}
