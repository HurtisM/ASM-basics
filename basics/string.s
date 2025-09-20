section .data
    string DB "ABC" ,0
    string2 Db "DEF" ,0

section .text
global _start

_start:
    MOV bl,[string]
    MOV eax,1
    INT 80h
