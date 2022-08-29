format MS64 COFF

public memcpy
public __memcpy_fwd

section '.text' code readable executable

;void *memcpy(void *dest, const void * src, size_t n)
; win: RCX=dext, RDX=src,  R8=n
; nix: RDI=dest, RSI=src, RDX=n
memcpy:
	mov r10, rdi
	mov r11, rsi
	mov rdi, rcx
	mov rsi, rdx
__memcpy_fwd:
	mov rax, rdi
	cmp r8, 8
	jc a
	test edi, 7
	jz a
b:	movsb
	dec r8
	test edi, 7
	jnz b
a:	mov rcx, r8
	shr rcx, 3
	rep
	movsq
	and r8d, 7
	jz d
c:	movsb
	dec r8d
	jnz c
d:	mov rdi, r10
	mov rsi, r11
	ret
