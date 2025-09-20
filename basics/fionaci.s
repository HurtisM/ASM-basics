section .data
    msg db "Sum of even Fibonacci numbers: ", 0
    msg_len equ $ - msg
    newline db 10, 0

section .bss
    num resb 10          ; Buffer for the string representation of the number

section .text
    global _start

_start:
    mov ecx, 1          ; Initialize ECX to 1
    mov edx, 0          ; Initialize EDX to 0
    xor ebx, ebx        ; Initialize EBX (sum)

_fib_loop:
    test ecx, 1         ; Check if ECX is odd
    jne _odd
_even:
    add ebx, ecx        ; Add even Fibonacci numbers to sum
_odd:
    xadd ecx, edx       ; Swap ECX and EDX, then add old EDX to new ECX
    cmp ecx, 1000000    ; Stop if ECX >= 1,000,000
    jc _fib_loop

    ; Convert EBX (sum) to a string
    mov esi, num        ; Pointer to buffer
    mov edi, 10         ; Base 10
    call int_to_str

    ; Print message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; File descriptor (stdout)
    mov ecx, msg        ; Pointer to message
    mov edx, msg_len    ; Length of message
    int 0x80

    ; Print the number
    mov eax, 4          ; sys_write
    mov ebx, 1          ; File descriptor (stdout)
    mov ecx, num        ; Pointer to number string
    mov edx, esi        ; Length of the number string
    sub edx, num
    int 0x80

    ; Print newline
    mov eax, 4          ; sys_write
    mov ebx, 1          ; File descriptor (stdout)
    mov ecx, newline    ; Pointer to newline
    mov edx, 1          ; Length of newline
    int 0x80

    ; Exit program
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; Exit code 0
    int 0x80

; Convert integer in EAX to a string in base EDI, store at ESI
int_to_str:
    xor ecx, ecx        ; Clear ECX (digit counter)
    mov ebx, eax        ; Copy value to EBX
    .loop:
        xor edx, edx    ; Clear EDX for division
        div edi         ; Divide EAX by EDI (base), remainder in EDX
        add dl, '0'     ; Convert digit to ASCII
        dec esi         ; Move buffer pointer backward
        mov [esi], dl   ; Store digit
        inc ecx         ; Increment digit counter
        test eax, eax   ; Check if quotient is 0
        jnz .loop       ; Repeat if not
    ret


