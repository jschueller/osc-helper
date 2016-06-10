#!/bin/sh

set -e

cd /tmp
rm -rf gcc-defaultsx
mkdir -p gcc-defaultsx
cd gcc-defaultsx

rm -rf *.diff.gz *.dsc r-base-2.15.1

wget -c http://archive.ubuntu.com/ubuntu/pool/main/g/gcc-defaults/gcc-defaults_1.150ubuntu1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/main/g/gcc-defaults/gcc-defaults_1.150ubuntu1.tar.gz

dpkg-source -x gcc-defaults_1.150ubuntu1.dsc

cd gcc-defaults-1.150ubuntu1
# nothing provides gcj-jdk
sed -i "s|, gcj-jdk|, gcj-5-jre-headless|g" debian/control
sed -i "s|@gcc_suffix@//|@gcc_suffix@/-5/|g" debian/rules

debuild -us -uc -S
cd ..
cp gcc-defaults_1.150ubuntu1.dsc gcc-defaults-xUbuntu_16.04.dsc
cp gcc-defaults-xUbuntu_16.04.dsc gcc-defaults_1.150ubuntu1.tar.gz ~/projects/science\:openturns/gcc-defaults
