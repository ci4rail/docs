#### Compile Demo

{% include content/tab-windows-linux.md head=true %}

```console
cd examples\{{ include.example_path }}\{{ include.example_name }}
GOOS=linux GOARCH=arm64 go build
```

{% include content/tab-windows-linux.md middle=true %}

```bash
cd examples/{{ include.example_path }}/{{ include.example_name }}
GOOS=linux GOARCH=arm64 go build
```

{% include content/tab-windows-linux.md foot=true %}

This produces the binary file `{{ include.example_name }}` in the current folder.

#### Copy Demo to ModuCop

Transfer the compiled binary. Replace `<moducop-ip>` with the IP address of your ModuCop.
We copy the binary to the `/data` folder of ModuCop, as this is a writeable, whereas the rest of the filesystem is write protected.

{% include content/tab-windows-linux.md head=true %}

```console
scp {{ include.example_name }} root@<moducop-ip>:/data
```

{% include content/tab-windows-linux.md middle=true %}

```bash
scp {{ include.example_name }} root@<moducop-ip>:/data
```

{% include content/tab-windows-linux.md foot=true %}

#### Running the Demo

```bash
ssh root@<moducop-ip>
```

Once logged in into the Moducop Shell:
```bash
/data/{{ include.example_name }}
```
