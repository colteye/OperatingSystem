gcc -c -m32 -fno-PIC -ffreestanding -nostdinc -Os -fomit-frame-pointer -g -gdwarf -Wall -Werror src/kernel/kernel.c -o build/kernel.o

nasm -f elf32 -g -F dwarf -Wall -Werror -i src/bootloader/ src/bootloader/boot.asm -o build/boot.o

::ld -m i386pe -T kernel.ld build/boot.o build/kernel.o -o build/kernel -build-id=none
ld -m i386pe -T kernel.ld build/boot.o -o build/kernel -build-id=none

objcopy -O binary build/kernel build/kernel.bin

pause