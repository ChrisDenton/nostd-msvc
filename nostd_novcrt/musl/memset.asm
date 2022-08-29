format MS64 COFF

public memset

section '.text' code readable executable

;void *memset(void *str, int c, size_t n)
; win: RCX=str, RDX=c,  R8=n
; nix: RDI=str, RSI=c, RDX=n
memset:
	mov r10, rdi
	mov rdi, rcx
	movzx rax, dl
	mov r9, 101010101010101h
	imul rax, r9

	cmp r8, 126
	ja a

	test edx, edx
	jz b

	mov [rdi], sil
	mov [rdi+r8-1], sil
	cmp edx, 2
	jbe b

	mov [rdi+1], ax
	mov [rdi+r8-1-2], ax
	cmp edx, 6
	jbe b

	mov [rdi+1+2], eax
	mov [rdi+r8-1-2-4], eax
	cmp edx, 14
	jbe b

	mov [rdi+1+2+4], rax
	mov [rdi+r8-1-2-4-8], rax
	cmp edx, 30
	jbe b

	mov [rdi+1+2+4+8], rax
	mov [rdi+1+2+4+8+8], rax
	mov [rdi+r8-1-2-4-8-16], rax
	mov [rdi+r8-1-2-4-8-8], rax
	cmp edx, 62
	jbe b

	mov [rdi+1+2+4+8+16], rax
	mov [rdi+1+2+4+8+16+8], rax
	mov [rdi+1+2+4+8+16+16], rax
	mov [rdi+1+2+4+8+16+24], rax
	mov [rdi+r8-1-2-4-8-16-32], rax
	mov [rdi+r8-1-2-4-8-16-24], rax
	mov [rdi+r8-1-2-4-8-16-16], rax
	mov [rdi+r8-1-2-4-8-16-8], rax

b:	mov rax, rdi
	mov rdi, r10
	ret

a:	test edi, 15
	mov r9, rdi
	mov [rdi+r8-8], rax
	mov rcx, r8
	jnz c

d:	shr rcx, 3
	rep stosq
	mov rax, r9
	mov rdi, r10
	ret

c:	xor edx, edx
	sub edx, edi
	and edx, 15
	mov [rdi], rax
	mov [rdi+8], rax
	sub rcx, r8
	add rdi, r8
	jmp d
