; hello-os
; TAB=4

; for FAT 12 format floppy disk

    DB  0xeb, 0x4e, 0x90
    DB  "HELLOIPL"  ; boot sector name(8byte)
    DW  512 ; 1 sector size(512)
    DB  1   ; cluster size(1)
    DW  1   ; FAT start at 1 sector
    DB  2   ; FAT how many(2)
    DW  224 ; root directory size(224 entry)
    DW  2880    ; this drive size(2880 sector)
    DB  0xf0    ; media type(0xf0)
    DW  9   ; FAT length(9 sector)
    DW  18  ; 1 track how many sector(18)
    DW  2   ; head how many(2)
    DD  0   ; no partation(0)
    DD  2880    ; re-this drive size(2880 sector)
    DB  0,0,0x29    ; ?
    DD  0xffffffff  ; (maybe) volume serial number
    DB  "HELLO-OS   "   ; disk name(11 byte)
    DB  "FAT12   "  ; format name(8 byte)
    RESB    18  ; (maybe)(18 byte)

; program body

    DB  0xb8, 0x00, 0x00, 0x8e, 0x10, 0xbc, 0x00, 0x7c
    DB  0x8e, 0x18, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
    DB  0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
    DB  0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
    DB  0xee, 0xf4, 0xeb, 0xfd

; message part

    DB  0x0a, 0x0a  ; two new line
    DB  "hello, world" ; !changed from original 
    DB  0x0a    ; new line
    DB  0

    RESB   0x1fe-($-$$) ; until 0x001fe padding 0x00 !changed from original

    DB  0x55, 0xaa

; not boot sector part

    DB  0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    4600
    DB  0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    1469432