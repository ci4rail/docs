Requirements on linux host:
* kernel must support FUSE (`FUSE_FS=y`)
* `libpthread` and `libfuse` must be installed in the root filesystem.
* git, autoconf, make, gcc installed

Build:
```bash
$ git clone https://gitlab.com/ci4rail/ttynvt.git
$ cd ttynvt
$ autoreconf -vif
$ ./configure
$ make
```
