global loader				; the entry symbol for ELF

MAGIC_NUMBER equ 0x1BADB002	; define the magic number constant
FLAGS equ 0x0				; multiboot flags
CHECKSUM equ -MAGIC_NUMBER	; calculate the checksum
							; (magic number + checksum + flags should equal 0)

section .tex				; start of the text (code) section
align 4						; the code mus be 4 byte aligned
    dd MAGIC_NUMBER			; write the magic number to the machine code,
    dd FLAGS				; the flags,
    dd CHECKSUM				; and the checksum

loader:						; the loader label (defined as entry point in the linker script)
    mov eax, 0xCAFEBABE		; place the number 0xCAFEBABE in the register eax
.loop
    jmp .loop				; loop forever
