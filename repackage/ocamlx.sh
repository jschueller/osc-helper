#!/bin/sh

set -e

cd /tmp
mkdir -p ocamlx
cd ocamlx

rm -rf *.diff.gz *.dsc ocaml-4.02.3

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/ocaml/ocaml_4.02.3-5ubuntu2.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/ocaml/ocaml_4.02.3.orig.tar.xz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/o/ocaml/ocaml_4.02.3-5ubuntu2.debian.tar.xz

dpkg-source -x ocaml_4.02.3-5ubuntu2.dsc

cd ocaml-4.02.3
# # nothing provides texlive-fonts-extra
sed -i "/quilt/d" debian/control
# # gzip: /usr/src/packages/BUILD/debian/r-base-core/usr/share/info/*.gz: No such file or directory
# sed -i "s|gunzip -9v|#gunzip -9v|g" debian/rules
# sed -i "s|dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|#dh_movefiles	--sourcedir=debian/\$(corepackage) -p\$(infopackage)|g" debian/rules

debuild -us -uc -S
cd ..
cp r-base_2.15.1-4.dsc r-base_2.15.1-4.diff.gz ~/projects/science\:openturns/r-basex

