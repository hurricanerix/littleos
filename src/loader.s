; the entry symbol for ELF
global loader

; align loaded modules on page boundries
ALI equ 1 << 0

; provide memory map
MEMINFO equ 1 << 1

; multiboot flags
FLAGS equ ALI | MEMINFO

; define the magic number constant
MAGIC_NUMBER equ 0x1BADB002

; calculate the checksum
CHECKSUM equ -(MAGIC_NUMBER + FLAGS)

; (magic number + checksum + flags shuold equal 0)

; start of the text (code) section
section .tex

; the code mus be 4 byte aligned
; write the magic number to the machine code,
; the flags,
; and the checksum
align 4
    dd MAGIC_NUMBER
    dd FLAGS
    dd CHECKSUM

; the loader label (defined as entry point in the linker script)
loader:
    ; place the number 0xCAFEBABE in the register eax
    mov eax, 0xCAFEBABE
.loop:
    ; loop forever
    jmp .loop
