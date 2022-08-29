Examples for `no_std` windows-sys that also doesn't use the CRT.
Note that this is a very unusual configuration. Even in `no_std` application you'd usually want the crt.
It does however use some vcruntime provided methods.

Also includes an example that does not even use the vcruntime (but I'm uncertain why you'd want this).
Maybe if you can write better mem* implementations than Microsoft.
