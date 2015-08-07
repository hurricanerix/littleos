OBJECTS=obj/loader.o obj/kmain.o
LINKER=ld
LINKER_FLAGS=-T src/link.ld -melf_i386
AS=nasm
ASFLAGS=-f elf32
CC=gcc
CFLAGS=-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
       -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
OUT_O_DIR=obj

dir_guard=mkdir -p $(@D)

all: os.iso

run: os.iso
	bochs -f bochsrc.txt -q

os.iso: iso/boot/grub/stage2_eltorito iso/boot/kernel.elf
	$(dir_guard)
	genisoimage -R \
		-b boot/grub/stage2_eltorito \
		-no-emul-boot                   \
		-boot-load-size 4               \
		-A os                           \
		-input-charset utf8             \
		-quiet                          \
		-boot-info-table                \
		-o os.iso                       \
		iso

iso/boot/grub/stage2_eltorito:
	$(dir_guard)
	cp grub/* iso/boot/grub/

iso/boot/kernel.elf: $(OBJECTS)
	$(dir_guard)
	$(LINKER) $(LINKER_FLAGS) $(OBJECTS) -o iso/boot/kernel.elf

$(OUT_O_DIR)/%.o: src/%.c
	$(dir_guard)
	$(CC) $(CFLAGS) $< -o $@

$(OUT_O_DIR)/%.o: src/%.s
	$(dir_guard)
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf iso obj os.iso bochslog.txt
