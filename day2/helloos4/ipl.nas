; hello-os
; TAB=4

    ORG 0x7c00 ; ブートセクタが読み込まれるアドレスの開始地点

; ディスクのための記述

    JMP entry
    DB  0x90
    DB  "HELLOIPL"  ; ブートセレクタの名前を自由に書いて良い(8byte)
    DW  512     ; 1セクタの大きさ
    DB  1   ; クラスタの大きさ
    DW  1   ; FATがどこからはじまるか
    DB  2   ; FATの個数
    DW  224 ; ルートディレクトリ領域の大きさ
    Dw  2880    ; このドライブの大きさ
    DB  0xf0    ; メディアタイプ
    DW  9       ; FAT領域の長さ
    DW  18      ; 1トラックにいくつのセクタがあるか
    DW  2       ; へっどの数
    DD  0       ; パーティションを使っていないのでここは必ず0
    DD 2880     ; このドライブの大きさをもう一度描く
    DB 0, 0, 0x29   ; よくわからないけどこの値にしておくといいらしい
    DD  0xffffffff  ; たぶんボリュームシリアル番号
    DB  "HELLO-OS   "   ; ディスクの名前(11byte)
    DB  "FAT12   "  ; フォーマットの名前(8byte)
    TIMES   18  DB  0  ; とりあえず18byteあけておく

; Main
entry:
    MOV AX, 0   ; レジスタ初期化
    MOV SS, AX
    MOV SP, 0x7c00
    MOV DS, AX
    MOV ES, AX

    MOV SI, msg
putloop:
    MOV AL, [SI]    ; BYTE accumulator low
    ADD SI, 1   ; 次のメモリの番地を指定
    CMP AL, 0   ; compare
    JE  fin     ; AL==0 -> finラベルへ
    MOV AH, 0x0e
    MOV BX, 15  ; colorcode
    INT 0x10    ; interrupt BIOS
    JMP putloop
fin: 
    HLT
    JMP fin
msg:
    DB  0x0a, 0x0a
    DB  "hello, OS!"
    DB  0x0a
    DB  0   ; end msg

    TIMES   0x7dfe-0x7c00-($-$$)    DB  0

    DB  0x55, 0xaa

; ブート以外の記述

    DB  0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    TIMES   4600    DB  0
    DB  0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    TIMES   1469432 DB  0