TOOLPATH = ../../helps/z_tools/
MAKE     = $(TOOLPATH)make -r
NASK     = $(TOOLPATH)nask
EDIMG    = $(TOOLPATH)edimg
# IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = cp
DEL      = del

# �f�t�H���g����

default :
	$(MAKE) img

# �t�@�C�������K��

ipl.bin : ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

haribote.img : ipl.bin Makefile
	$(EDIMG)   imgin:$(TOOLPATH)/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0   imgout:haribote.img

# �R�}���h

asm :
	$(MAKE) ipl.bin

img :
	$(MAKE) haribote.img

run :
	$(MAKE) img
	$(COPY) haribote.img $(TOOLPATH)/qemu/fdimage0.bin
	$(MAKE) -C $(TOOLPATH)/qemu

# install :
# 	$(MAKE) img
# 	$(IMGTOL) w a: haribote.img

clean :
	-$(DEL) ipl.bin
	-$(DEL) ipl.lst

src_only :
	$(MAKE) clean
	-$(DEL) haribote.img
