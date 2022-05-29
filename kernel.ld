/* We define an entry point to keep the linker quiet. This entry point
 * has no meaning with a bootloader in the binary image we will eventually
 * generate. Bootloader will start executing at whatever is at 0x07c00 
ENTRY(start);*/
SECTIONS
{
    . = 0x7C00;
    .text : {
        /* Place the code in hw.o before all other code */
        build/boot.o(.text);
        *(.text);
    }

    /* Place the data after the code */
    .data : {
        *(.data);
        *(.rodata*);
    }

    .bss : { 
        *(.bss) 
    }
}