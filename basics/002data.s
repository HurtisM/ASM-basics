; storing numeric data
; DB  one byte, DW  two bytes = 16 bits,
; DD 4 bytes = 32 bits and DQ 8 bytes =64bits  
; DT 10 bytes 80 bits

section .data
    num DB 51		;
    num2 DB 42

section .text
global _start



_start:
    ;MOV ebx,num	toto ulozi do regista adresu pamate kde sa nachadza premenna num
    MOV bl,[num]	; toto ulozi do registra hodnotu premennej num
    MOV cl,[num2]	; 
    MOV eax,1
    INT 80h
 
