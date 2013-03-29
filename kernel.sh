#!/bin/sh

CWD=$(dirname $(readlink -f $0))
export PATH=$CWD/tools/compiler/bin:$PATH
#wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.8.4.tar.xz
#tar xvJf linux-3.8.4.tar.xz
tar xvjf linux-3.8.2.tar.bz2

cd linux-3.8.2
make ARCH=powerpc CROSS_COMPILE=powerpc-unknown-linux-gnu- pmac32_defconfig
make ARCH=powerpc CROSS_COMPILE=powerpc-unknown-linux-gnu- -j 8
