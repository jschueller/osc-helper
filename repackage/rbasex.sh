#!/bin/sh

set -e

cd /tmp
mkdir -p rbasex
cd rbasex

rm -rf *.diff.gz *.dsc r-base-2.15.1

wget -c http://ftp.de.debian.org/debian/pool/main/r/r-base/r-base_2.15.1.orig.tar.gz
wget -c http://ftp.de.debian.org/debian/pool/main/r/r-base/r-base_2.15.1-4.diff.gz
wget -c http://ftp.de.debian.org/debian/pool/main/r/r-base/r-base_2.15.1-4.dsc

dpkg-source -x r-base_2.15.1-4.dsc

cd r-base-2.15.1/
# nothing provides texlive-fonts-extra
sed -i "s|, texlive-fonts-extra||g" debian/control
# gzip: /usr/src/packages/BUILD/debian/r-base-core/usr/share/info/*.gz: No such file or directory
sed -i "s|gunzip -9v|#gunzip -9v|g" debian/rules
sed -i "s|dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|#dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|g" debian/rules

debuild -us -uc -S
cd ..
cp r-base_2.15.1-4.dsc r-base_2.15.1-4.diff.gz ~/projects/science\:openturns/r-basex

