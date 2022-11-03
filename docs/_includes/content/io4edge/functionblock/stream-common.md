<!---
Pass the following parameters in the include directive:
- example_keep_alive - code snippet for keep alive interval
- example_all_options - code snippet for all options
- describe_low_latency - true/false
--->


It is possible to fine-tune the stream behavior to the application needs:

Configure a keep alive interval, then you get a bucket latest after the configured interval, regardless whether the bucket is full or not:

{{ include.example_keep_alive }}

Configure the number of samples per bucket. By default, a bucket contains max. 25 samples. This means, the bucket is sent when at least 25 samples are available. If number of buckets per sample is changed, the number of buffered samples for this stream in the device must be changed accordingly.
As a rule of thumb, `Buffered Samples` should be at least two times the number of samples in the bucket. Select a higher number if your reception process is slow to avoid buffer overruns.

{% if include.describe_low_latency %}
If you want low latency on the received data, you can enable the "low latency" mode. In this mode, samples are sent as soon as possible after they have been received. This means that the buckets contain `1..<samples-per-bucket>` samples.
{% endif %}

{{ include.example_all_options }}
