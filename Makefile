TREE_FILES=$(shell find tree -print)

rootfs.cpio.gz: $(TREE_FILES)
	rm -f $@
	cd tree && find . | cpio -o -v --format=newc | gzip > ../$@

view:
	mkdir -p tmp
	cd tmp && gunzip ../rootfs.cpio.gz -c | cpio -i --make-directories

hello: hello.c
	$(CROSS_COMPILE)gcc -static-libgcc -o hello hello.c
