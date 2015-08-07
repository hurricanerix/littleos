/* the name of the entry label */
ENTRY(loader)

SECTIONS {
	/* the code should be loaded at 1 MB */
	. = 0x00100000;

	/* align at 4 KB */
	.text ALIGN (0x1000) :
	{
		/* all text sections from all files */
		*(.text)
	}

	/* align at 4KB */
	.rodata ALIGN (0x1000) :
	{
		/* all read-only data sections from all files */
		*(.rodata*)
	}

	/* align at 4KB */
	.data ALIGN (0x1000) :
	{
		/* all data sections from all files */
		*(.data)
	}

	/* align at 4KB */
	.bss ALIGN (0x1000) :
	{
		/* all COMMON sections from all files */
		*(COMMON)
		/* all bss sections from all files */
		*(.bss)
	}
}
