#!/bin/sh

set -e

cd /tmp
rm -rf ttfautohinttx
mkdir -p ttfautohinttx
cd ttfautohinttx

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/t/ttfautohint/ttfautohint_0.97-1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/t/ttfautohint/ttfautohint_0.97.orig.tar.gz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/t/ttfautohint/ttfautohint_0.97-1.debian.tar.gz

dpkg-source -x ttfautohint_0.97-1.dsc

cd ttfautohint-0.97
sed -i "s|--with autoreconf||g" debian/rules

debuild -us -uc
debuild -us -uc -S
cd ..
cp ttfautohint_0.97-1.dsc ttfautohint-xUbuntu_16.04.dsc
cp -v ttfautohint-xUbuntu_16.04.dsc ttfautohint_0.97-1.debian.tar.gz ~/projects/science\:openturns/ttfautohint
