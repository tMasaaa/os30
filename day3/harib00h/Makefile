TOOLPATH = ../../helps/z_tools/
MAKE     = $(TOOLPATH)make -r
NASK     = $(TOOLPATH)nask
EDIMG    = $(TOOLPATH)edimg
# IMGTOL   = $(TOOLPATH)imgtol.com
COPY     = cp
DEL      = del


default :
	$(MAKE) img


ipl.bin : ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

haribote.sys : haribote.nas Makefile
	$(NASK) haribote.nas haribote.sys haribote.lst

haribote.img : ipl.bin haribote.sys Makefile
	$(EDIMG)   imgin:$(TOOLPATH)/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		imgout:haribote.img

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
	-$(DEL) haribote.sys
	-$(DEL) haribote.lst

src_only :
	$(MAKE) clean
	-$(DEL) haribote.img
