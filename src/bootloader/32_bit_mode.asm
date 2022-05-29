[bits 16]
enter_protected_mode:
    ; change the video mode to 0x03
    mov ax, 0x03
    call A20_enable

    ; disable interrupts
    cli
    lgdt [GDT_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp GDT_code_size:start_protected_mode

;Enable A20 bit, allow memory > 1Mib
A20_enable:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]
start_protected_mode:
    mov ax, GDT_data_size
    mov ds, ax
    mov es, ax 
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Redefine stack pointer to larger value now we have 4GiB of memory to work with
    mov ebp, 0x90000
    mov esp, ebp

    mov ebx, PM_START_MSG
    call print_string_32

    jmp $

; Includes
%include "gdt.asm"
%include "print_32.asm"

; Variables
PM_START_MSG db "Protected Mode Initialized", 0