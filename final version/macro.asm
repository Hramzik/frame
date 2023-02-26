

VIDMEM equ 0b800h

;----------------------------------
; loads ES with video seg addr
;----------------------------------
; entry:    none
; exit:     ES = 0b800h
; destroys: bx; самая важная часть!
;----------------------------------
loadvideoes macro

    nop
    mov bx, VIDMEM
    mov ES, bx
    nop

    endm
;----------------------------------

;----------------------------------------------
; exit to dos
;----------------------------------------------
; entry: n/a
; exit:  n/a
; destr: n/a
;----------------------------------------------
myexit macro

    nop
    mov ax, 4c00h
    int 21h
    nop

    endm
;----------------------------------------------