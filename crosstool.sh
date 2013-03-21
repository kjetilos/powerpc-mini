#!/bin/sh

CWD=$(dirname $(readlink -f $0))

if [ ! -f crosstool-ng-1.18.0.tar.bz2 ]
then
  wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.18.0.tar.bz2
fi

if [ ! -d crosstool-ng-1.18.0 ]
then
  tar xvjf crosstool-ng-1.18.0.tar.bz2
fi

cd crosstool-ng-1.18.0
echo Configure crosstool to path $CWD/tools/crosstool-ng
./configure --prefix=$CWD/tools/crosstool-ng


