; #######################################################
; Print string using video memory (32 bit protected mode)
; #######################################################
[bits 32]

print_string_32:
    pusha
    ; Push video memory address to edx.
    mov edx, VIDEO_MEMORY

.print_char:
    ; Get the char
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    ; Jump to done if ending code is found 
    cmp al, 0x00
    je .done

    ; Else print
    mov [edx], ax
    inc ebx
    add edx, 2

    ; and jump back to .print_char
    jmp .print_char

.done:
    popa
    ret

; Variables
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f