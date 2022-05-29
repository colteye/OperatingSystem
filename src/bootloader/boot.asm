; Begin Initializing system!
;[org 0x7c00]

xor ax, ax      ; We want a segment of 0 for DS for this question
mov ds, ax      ; Set AX to appropriate segment value for your situation
mov es, ax      ; In this case we'll default to ES=DS
mov bx, 0x8000  ; Stack segment can be any usable memory

cli             ; Disable interrupts to circumvent bug on early 8088 CPUs
mov ss, bx      ; This places it with the top of the stack @ 0x80000.
mov sp, ax      ; Set SP=0 so the bottom of stack will be @ 0x8FFFF
sti             ; Re-enable interrupts

cld             ; Set the direction flag to be positive direction

; Read some sectors from disk.
call disk_load

; Enter protected mode and start running kernel.
jmp enter_protected_mode

; Includes
%include "disk_load.asm"
%include "32_bit_mode.asm"

; Boot sector padding + magic number
times 510 - ($ - $$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 2048 db 0

