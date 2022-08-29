format MS64 COFF

public memmove
extrn __memcpy_fwd

section '.text' code readable executable

;void * memmove ( void * dest, const void * src, size_t n );
; win: RCX=dest, RDX=src,  R8=n
; nix: RDI=dest, RSI=src, RDX=n
memmove:
	mov r10, rdi
	mov r11, rsi
	mov rdi, rcx
	mov rsi, rdx
	
	mov rax, rdi
	sub rax, rsi
	cmp rax, r8
	jae __memcpy_fwd
	mov rcx, r8
	lea rdi, [rdi+r8-1]
	lea rsi, [rsi+r8-1]
	std
	rep movsb
	cld
	lea rax, [rdi+1]
	
	mov rdi, r10
	mov rsi, r11
	ret
