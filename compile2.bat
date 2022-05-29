gcc -c -m32 -fno-PIC -ffreestanding -nostdinc -Os -fomit-frame-pointer -g -gdwarf -Wall -Werror src/kernel/kernel.c -o build/kernel.o

objcopy -j .text -O binary build/kernel.o build/kernelb.o

nasm -f bin -i boot.asm -o boot.o

ld -T kernel.ld build/boot.o build/kernelb.o -o build/kernel -build-id=none

pause