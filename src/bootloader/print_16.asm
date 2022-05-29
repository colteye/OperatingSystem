; ################################
; Print string using bios routines
; ################################
[bits 16]

print_string_16:
    ; Set string print function
    mov ah, 0x0e          

.print_char:
    ; Get the char
    mov al, [bx]

    ; Jump to done if ending code is found 
    cmp al, 0x00
    je .done

    ; Else print
    int 0x10            
    inc bx

    ; and jump back to .print_char
    jmp .print_char

.done:
    ret