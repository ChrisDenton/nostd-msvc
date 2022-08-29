format MS64 COFF

; Code is adapted from rust-lang/compiler-builtins
; https://github.com/rust-lang/compiler-builtins/blob/42a4b7965c22502887b93219484fce45ab4e1909/src/probestack.rs
; Copyright 2017 The Rust Project Developers
; Used under the MIT license

public __chkstk
public _alloca_probe

PAGE_SIZE = 4 * 1024;

section '.text' code readable executable

; The internet tells me this is also called `_alloca_probe`
; so I'll use both symbols here just in case.
__chkstk:
_alloca_probe:
    push  rbp
    mov  rbp, rsp
    ; duplicate rax as we're clobbering r11
    mov   r11, rax
    ; Main loop, taken in one page increments. We're decrementing rsp by
    ; a page each time until there's less than a page remaining. We're
    ; guaranteed that this function isn't called unless there's more than a
    ; page needed.
    ;
    ; Note that we're also testing against `[rsp + 8]` to account for the 8
    ; bytes pushed on the stack orginally with our return address. Using
    ; `[rsp + 8]` simulates us testing the stack pointer in the caller's
    ; context.
    ; It's usually called when rax >= 0x1000, but that's not always true.
    ; Dynamic stack allocation, which is needed to implement unsized
    ; rvalues, triggers stackprobe even if rax < 0x1000.
    ; Thus we have to check r11 first to avoid segfault.
    cmp    r11, PAGE_SIZE
    jna    .end
.loop:
    sub    rsp, PAGE_SIZE
    test   [rsp + 8], rsp
    sub    r11, PAGE_SIZE
    cmp    r11, PAGE_SIZE
    ja     .loop
.end:
    ; Finish up the last remaining stack space requested, getting the last
    ; bits out of r11
    sub    rsp, r11
    test   [rsp + 8], rsp
    ; Restore the stack pointer to what it previously was when entering
    ; this function. The caller will readjust the stack pointer after we
    ; return.
    add    rsp, rax
    leave
    ret
