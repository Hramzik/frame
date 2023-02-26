.186
.model tiny
.code
org 100h
locals @@


start:
    jmp main


ENDL equ 96; code for ` (tilda without shift)


include center.asm
include  macro.asm
include  frame.asm
include  style.asm
include   text.asm
include    cmd.asm


main:

    call drawcmd

    myexit

end start