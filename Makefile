LINKER=ld
LINKER_FLAGS=-melf_i386
ASM=nasm
ASM_FLAGS=-f elf32

all: iso

run: iso
	bochs -f bochsrc.txt -q

iso: iso/boot/kernel.elf
	mkdir -p iso/boot/grub
	cp grub/* iso/boot/grub/
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

iso/boot/kernel.elf: obj/loader.o
	mkdir -p iso/boot
	$(LINKER) -T src/link.ld $(LINKER_FLAGS) obj/loader.o -o iso/boot/kernel.elf

obj/loader.o: src/loader.s
	$(ASM) $(ASM_FLAGS) src/loader.s -o obj/loader.o

clean:
	rm -f iso/boot/kernel.elf
	rm -f iso/boot/grub/stage2_eltorito
	rm -f obj/*
	rm os.iso
	rm -f bochslog.txt
