.PHONY: clean play debug

main.gba: main.elf
	arm-none-eabi-objcopy -v -O binary main.elf main.gba
	gbafix main.gba

main.o: main.c
	arm-none-eabi-gcc --std=c99 -g -c main.c -mthumb-interwork -mthumb -O0 -o main.o

main.elf: main.o
	arm-none-eabi-gcc -g main.o -mthumb-interwork -mthumb -specs=gba.specs -o main.elf

clean:
	rm main.o main.elf main.gba

play: main.gba
	vba main.gba

debug: main.elf
	vba -Gtcp 1>/dev/null 2>/dev/null &
	arm-none-eabi-gdb -x .gdb-boot --tui
