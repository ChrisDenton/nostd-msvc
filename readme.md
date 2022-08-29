Examples for `no_std` windows-sys.

There are three crates here:

* **nostd** A normal `no_std` application.
* **nocrt** A `no_std` application without CRT startup. It does however use some vcruntime provided methods.
* **novcrt** A `no_std` application without CRT startup or the vcruntime library. This requires defining our own memcpy, etc functions.

Note that all but **nostd** are very unusual configuration. Even in a `no_std` application you'd usually want the CRT.

**novcrt** is by far the most niche as it does not even use the vcruntime (but I'm uncertain why you'd want this).
Maybe if you can write better mem* implementations than Microsoft.
