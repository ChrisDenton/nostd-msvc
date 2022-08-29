; This is a very basic byte compare loop.
; Probably would be better optimized if written in Rust.
format MS64 COFF

public memcmp

section '.text' code readable executable

memcmp:
    test   rdx, rdx
    je     .equal
    xor    ecx, ecx

.loop:
    movzx  eax, byte [rdi + rcx]
    movzx  r8d, byte [rsi + rcx]
    cmp    al, r8b
    jne    .diff
    add    rcx, 1
    cmp    rdx, rcx
    jne    .loop

.equal:
    xor    eax, eax
    ret

.diff:
    sub    eax, r8d
    ret
