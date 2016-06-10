#!/bin/sh

set -e

cd /tmp
rm -rf libtest-differences-perl
mkdir -p libtest-differences-perl
cd libtest-differences-perl

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtest-differences-perl/libtest-differences-perl_0.64-1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtest-differences-perl/libtest-differences-perl_0.64.orig.tar.gz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/libt/libtest-differences-perl/libtest-differences-perl_0.64-1.debian.tar.xz

dpkg-source -x libtest-differences-perl_0.64-1.dsc

# cd javatools_0.54ubuntu1
cd libtest-differences-perl-0.64
# nothing provides gcj-jdk
sed -i "s|libcapture-tiny-perl (>= 0.24)|perl|g" debian/control
sed -i "/libtext-diff-perl (>= 1.43),/d" debian/control


# sed -i "s|@gcc_suffix@//|@gcc_suffix@/-5/|g" debian/rules

debuild -us -uc -S
cd ..
cp libtest-differences-perl_0.64-1.dsc libtest-differences-perl-xUbuntu_16.04.dsc
cp libtest-differences-perl-xUbuntu_16.04.dsc libtest-differences-perl_0.64-1.debian.tar.gz libtest-differences-perl_0.64.orig.tar.gz ~/projects/science\:openturns/libtest-differences-perl
