; GDT = Global Descriptor Table
; Defines memory layout
; Works with sections of memory, we need 3

; Required
GDT_null:
    dd 0
    dd 0

; Defines segment for storing code
GDT_code:
    dw 0xFFFF       ; limit
    dw 0x0000       ; base (low)
    db 0x00         ; base (med)
    db 10011010b    ; flags
    db 11001111b    ; flags + upper limit
    db 0x00         ; base (high)

; Defines segment for storing data
GDT_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

; This is how code and data are seperated
GDT_end:

; What is passed to CPU register when GDT is passed, describes GDT
GDT_descriptor:
    GDT_size:
        dw GDT_end - GDT_null - 1
        dd GDT_null

GDT_code_size equ GDT_code - GDT_null
GDT_data_size equ GDT_data - GDT_null