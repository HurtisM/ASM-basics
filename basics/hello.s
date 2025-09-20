section .data
    msg DB 'Hello',0xa
    len EQU $ - msg

section .text
global _start

_start:
    MOV edx,len
    MOV ecx,msg
    MOV ebx,1
    MOV eax,4
    INT 80h

    MOV eax,1
    INT 80h
