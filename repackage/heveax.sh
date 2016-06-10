#!/bin/sh
#sudo aptitude install dh-ocaml
set -e

cd /tmp
mkdir -p heveax
cd heveax

rm -rf *.diff.gz *.dsc hevea-2.23/

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/hevea/hevea_2.23-2build1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/hevea/hevea_2.23.orig.tar.gz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/h/hevea/hevea_2.23-2build1.debian.tar.xz

dpkg-source -x hevea_2.23-2build1.dsc

cd hevea-2.23/
sed -i "/ocaml-nox/d" debian/control
# # nothing provides texlive-fonts-extra
# sed -i "s|, texlive-fonts-extra||g" debian/control
# # gzip: /usr/src/packages/BUILD/debian/r-base-core/usr/share/info/*.gz: No such file or directory
# sed -i "s|gunzip -9v|#gunzip -9v|g" debian/rules
# sed -i "s|dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|#dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|g" debian/rules

debuild -us -uc -S
cd ..
# cp r-base_2.15.1-4.dsc r-base_2.15.1-4.diff.gz ~/projects/science\:openturns/r-basex

