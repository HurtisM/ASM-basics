section .bss
	num	RESB 3		;raw data buffer
	hexout	RESB 11		; 3bytes -> "01 01 01" 

section .text
global _start

;----------------------------------------------
;Convert a byte in AL -> two hex chars at [EDI]
;----------------------------------------------
to_hex:
	push ecx
	push eax

	mov ecx, 2		; 2 hex digits
.hex_loop:
	rol al,4		; bring high nibble first, then low
	mov bl,al
	and bl, 0x0F		; isolate nibble
	cmp bl,9
	jbe .digit
	add bl, 'A' - 10		; A-F
	jmp .store
.digit:
	add bl, '0'		; 0-9
.store:
	mov [edi], bl
	inc edi
	loop .hex_loop

	pop eax
	pop ecx
	ret

;-----------------------------------------------
; main program
;----------------------------------------------
_start:
	; fill the buffer with numbers
    mov byte [num], 1
	mov byte [num+1], 42
	mov byte [num+2], 255

	; convert num to hex
	mov esi, num
	mov edi, hexout
	mov ecx, 3 		; 3  bytes
.convert_loop:
	mov al, [esi]
	call to_hex
	inc esi

	cmp ecx, 1		; last byte?
	je .no_space
	mov byte [edi], ' '	;add space
.no_space:
	loop .convert_loop

	; write result to stdout
	mov eax, 4
	mov ebx, 1		; fd = stdout
	mov ecx, hexout		; buffer
	mov edx, 8		; 8 chars ("xx xx xx")
	int 0x80

	;exit
	mov eax, 1 		; sys exit
	xor ebx, ebx
	int 0x80


