disk_load:
    ; BIOS stores our boot drive in DL, remember for later.
    mov [BOOT_DRIVE], dl           

    ; BIOS read sector function
    mov ah, 0x02

    ; Load 4 sectors from the boot disk.
    mov bx, PROGRAM_SPACE          
    mov al, 4
    mov dl, [BOOT_DRIVE]

    ; Select cylinder 0, head 0, reading from second sector.
    mov ch, 0x00   
    mov dh, 0x00
    mov cl, 0x02

    ; BIOS interrupt.
    int 0x13

    ; Jump if error (i.e. carry flag set)
    jc disk_error

    ; Otherwise write success!
    mov bx, DISK_SUCCESS_MSG
    call print_string_16

    ret

; Write disk error message to screen.
disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string_16
    jmp $

; Includes
%include "print_16.asm"

; Variables
PROGRAM_SPACE equ 0x7e00
DISK_ERROR_MSG db "Disk: Read Error!", 0
DISK_SUCCESS_MSG db "Disk: Read Successful!", 0
BOOT_DRIVE: db 0