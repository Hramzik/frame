

;----------------------------------------------
; draws a centered frame with text using cmd args
;----------------------------------------------
; usage:   <color> <style> [frame symb.] <text $>
; exit:    none
; destr:   ax, bx, bp, cx, dx, si, di
;----------------------------------------------

drawcmd proc

    mov bx, 80h
    xor ch, ch
    mov cl, [bx]; cmd len
    add bx, 1

    call skipspaces

    call readhex

    xor ah, ah
    mov si, ax; color

    call skipspaces

    call readstyle

    cmp di, 0; style0
    jne @@styleN

    @@style0:
        call skipspaces
        mov bp, bx
        add bx, 9
        sub cx, 9

    @@styleN:
        call skipspaces
        call centerall
        ret

    endp
;----------------------------------------------


;----------------------------------------------
; reads a hex ascii 00-FF number to al
;----------------------------------------------
; entry:  [bx] - first byte
; exit:    al  = number
;         [bx], [bx+1] are changed to digits values
;     new [bx] = first byte after number
;          cx -= 2
; destr:   al, bx, cx, dl
;----------------------------------------------

readhex proc


    call bxtohex
    mov al, [bx]
    mov dl, 16
    mul dl

    add bx, 1
    call bxtohex
    add al, [bx]

    add bx, 1
    sub cx, 2

    ret
    endp
;----------------------------------------------


;----------------------------------------------
; changes ascii hex codes in [bx] to it's value
;----------------------------------------------
; entry:   bx  - adress
; exit:   [bx] = hex value (bx)
; destr:   n/a
;----------------------------------------------

bxtohex proc

    cmp [bx], byte ptr 57; 0-9???
    jbe @@digittohex

    cmp [bx], byte ptr 70; A-F???
    jbe @@bigtohex

    cmp [bx], byte ptr 102; a-f???
    jbe @@smalltohex

    @@bigtohex:
        sub [bx], byte ptr 55d; A-F
        jmp @@end

    @@smalltohex:
        sub [bx], byte ptr 87d; a-f
        jmp @@end

    @@digittohex:
        sub [bx], byte ptr 48d; 0-9
        jmp @@end

    @@end:
    ret
    endp

;----------------------------------------------


;----------------------------------------------
; moves [bx] to the nearest non-space symbol
;----------------------------------------------
; exit:  [bx] - non-space symbol
;         cx -= spaces skipped 
; destr:  bx, cx
;----------------------------------------------

skipspaces proc

    @@next:
        cmp [bx], byte ptr 32; space
        jne @@end

        add bx, 1
        sub cx, 1
        jmp @@next
    @@end:

    ret
    endp
;----------------------------------------------


;----------------------------------------------
; reads a 0-9 style to di
;----------------------------------------------
; entry:  [bx] - ascii 0-9
; exit:    di  = 0-9
;     new [bx] = first byte after 0-9
;          cx -= 1
; destr:   bx, dx
;----------------------------------------------

readstyle proc

    call bxtohex
    xor dh, dh
    mov dl, [bx]
    mov di, dx

    add bx, 1
    sub cx, 1

    ret
    endp
;----------------------------------------------