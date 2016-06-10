#!/bin/sh

set -e

cd /tmp
rm -rf javatoolsx
mkdir -p javatoolsx
cd javatoolsx

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/j/javatools/javatools_0.54ubuntu1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/j/javatools/javatools_0.54ubuntu1.tar.xz

dpkg-source -x javatools_0.54ubuntu1.dsc

# cd javatools_0.54ubuntu1
cd javatools-0.54ubuntu1/
# nothing provides gcj-jdk
sed -i "/libtest-minimumversion-perl/d" debian/control
sed -i "/libtest-perl-critic-perl/d" debian/control
sed -i "/libtest-strict-perl/d" debian/control


# sed -i "s|@gcc_suffix@//|@gcc_suffix@/-5/|g" debian/rules

debuild -us -uc -S
cd ..
cp javatools_0.54ubuntu1.dsc javatools-xUbuntu_16.04.dsc
cp javatools-xUbuntu_16.04.dsc javatools_0.54ubuntu1.tar.gz ~/projects/science\:openturns/javatools
