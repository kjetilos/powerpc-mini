#!/bin/sh

CWD=$(dirname $(readlink -f $0))
export PATH=$CWD/tools/compiler/bin:$PATH
FILE=linux-3.8.5.tar.xz
DIR=linux-3.8.5
SYSROOT=$CWD/tree

if [ ! -f $FILE ]
then
  wget https://www.kernel.org/pub/linux/kernel/v3.x/$FILE
fi

if [ ! -d $DIR ]
then
  tar xvJf $FILE
fi

cd $DIR
make ARCH=powerpc CROSS_COMPILE=powerpc-unknown-linux-gnu- pmac32_defconfig
make ARCH=powerpc CROSS_COMPILE=powerpc-unknown-linux-gnu- -j 8
make ARCH=powerpc CROSS_COMPILE=powerpc-unknown-linux-gnu- INSTALL_MOD_PATH="${SYSROOT}" modules_install
