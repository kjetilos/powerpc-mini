#!/bin/bash

CWD=$(dirname $(readlink -f $0))
FILE=qemu-1.4.0.tar.bz2
DIR=qemu-1.4.0

if [ ! -f $FILE ]
then
  wget http://wiki.qemu-project.org/download/$FILE
fi

if [ ! -d $DIR ]
then
  tar xvjf $FILE
fi

cd $DIR
./configure --prefix=$CWD/tools/emulator --target-list=ppc-softmmu --enable-sdl
make -j 8 && make install
