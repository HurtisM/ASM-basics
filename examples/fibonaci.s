section .data
    msg db "Sum of even Fibonacci numbers: ", 0
    msg_len equ $ - msg
    newline db 10

section .bss
    num resb 12     ; buffer for number string (enough for 1,000,000+)

section .text
    global _start

_start:
    mov ecx, 1          ; first Fibonacci number
    mov edx, 0          ; second Fibonacci number
    xor ebx, ebx        ; sum = 0

_fib_loop:
    test ecx, 1         ; check if odd
    jne _odd
    add ebx, ecx        ; add even fib numbers
_odd:
    xadd ecx, edx       ; next Fibonacci number
    cmp ecx, 4000000
    jb _fib_loop        ; loop while ecx < 1,000,000

    ; Convert EBX (sum) to string
    mov eax, ebx
    mov esi, num + 11   ; point to end of buffer
    mov edi, 10
    call int_to_str

    ; Print message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; Print number
    mov eax, 4
    mov ebx, 1
    mov ecx, esi        ; esi points to start of number string
    mov edx, num + 12
    sub edx, esi        ; length of string
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80

; int_to_str: converts integer in EAX to ASCII string (base in EDI), result ends at ESI
int_to_str:
    xor ecx, ecx
.convert_loop:
    xor edx, edx
    div edi
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .convert_loop
    ret
