# ファイル生成規則
helloos.img: ipl.nas Makefile
	nasm ipl.nas -o helloos.img

img:
	make helloos.img

run:
	make img
	qemu-system-i386 -drive file=helloos.img,format=raw,if=floppy