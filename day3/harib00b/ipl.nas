; haribote-ipl
; TAB=4

    ORG 0x7c00 ; ブートセクタが読み込まれるアドレスの開始地点

; ディスクのための記述

    JMP entry
    DB  0x90
    DB  "HARIBOTE"  ; ブートセレクタの名前を自由に書いて良い(8byte)
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
    DB  "HARIBOTEOS "   ; ディスクの名前(11byte)
    DB  "FAT12   "  ; フォーマットの名前(8byte)
    TIMES   18  DB  0  ; とりあえず18byteあけておく

; Main
entry:
    MOV AX, 0   ; レジスタ初期化
    MOV SS, AX
    MOV SP, 0x7c00
    MOV DS, AX


;

    MOV AX, 0x0820
    MOV ES, AX
    MOV CH, 0 ; シリンダ0
    MOV DH, 0 ; ヘッド0
    MOV CL, 2   ; セクタ2

    MOV AH, 0x02    ; AH=0x02 ディスク読み込み
    MOV AL, 1       ; 1セクタ
    MOV BX, 0       
    MOV DL, 0x00
    INT 0x13
    JC  error



fin: 
    HLT
    JMP fin

error:
    MOV AX, 0
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
msg:
    DB  0x0a, 0x0a
    DB  "load error"
    DB  0x0a
    DB  0   ; end msg

    TIMES   0x7dfe-0x7c00-($-$$)    DB  0

    DB  0x55, 0xaa