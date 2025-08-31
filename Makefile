CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
GDB = arm-none-eabi-gdb

CFLAGS = -mcpu=cortex-m3 -mthumb -Os -Wall -nostdlib
LDFLAGS = -T linker.ld

SRCS_C = main.c
SRCS_S = startup.s
OBJS = $(SRCS_C:.c=.o) $(SRCS_S:.s=.o)

all: main.elf main.bin

main.elf: startup.o main.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

main.bin: main.elf
	$(OBJCOPY) -O binary $< $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: main.elf
	qemu-system-arm -M stm32vldiscovery  -cpu cortex-m3 -kernel $< -nographic

qemu-gdb: main.elf
	qemu-system-arm -M stm32vldiscovery  -cpu cortex-m3 -kernel $< \
		-S -gdb tcp::1234 -nographic

gdb: main.elf
	gdb-multiarch main.elf

clean:
	rm -f *.o *.elf *.bin