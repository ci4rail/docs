<!---
Pass the following parameters in the include directive:
- example_name - name of the example in camel case
--->
{% include content/tabv2/start.md tabs="go, python" %}

<!--- GO START --->
First, [install the io4edge client library]({{ '/edge-solutions/io4edge/go-client' | relative_url }}).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-go/tree/main/examples/{{ include.example_name }}).

<!--- GO END --->
{% include content/tabv2/next.md %}
<!--- PYTHON START --->
First, [install the io4edge client library]({{ '/edge-solutions/io4edge/python-client' | relative_url }}).

Want to have a quick look to the examples? See our [Github repository](https://github.com/ci4rail/io4edge-client-python/tree/main/examples/{{ include.example_name | downcase }}).

<!--- PYTHON END --->
{% include content/tabv2/end.md %}
