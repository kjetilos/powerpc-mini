#!/bin/bash

CWD=$(dirname $(readlink -f $0))
echo wget qemu
#tar xvjf qemu-1.4.0.tar.bz2
#cd qemu-1.4.0
./configure --prefix=$CWD/tools/emulator --target-list=ppc-softmmu --enable-sdl
make -j 8 && make install
