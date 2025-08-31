ENTRY(Reset_Handler)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 128K
  RAM   (rwx): ORIGIN = 0x20000000, LENGTH = 8K
}

SECTIONS
{
  .text : {
    KEEP(*(.isr_vector))
    *(.text*)
    *(.rodata*)
  } > FLASH

  .data : AT(__etext) {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM

  .bss : {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > RAM

  __etext = LOADADDR(.data);
  _sidata = __etext;
  _estack = ORIGIN(RAM) + LENGTH(RAM);
}