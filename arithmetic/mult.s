
section .text
global _start

_start:
	MOV al, 2
	MOV bl, 3
	MUL bl
	INT 80h

