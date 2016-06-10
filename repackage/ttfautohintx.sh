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
cat > debian/patches/fix-ftlib.patch <<EOF
--- a/configure.ac      2016-06-10 16:12:21.000000000 +0000
+++ b/configure.ac      2016-06-10 16:15:40.805790084 +0000
@@ -84,7 +84,7 @@
 FREETYPE_LIBS="\`\$ft_config --libtool\`"
 
 # many platforms no longer install .la files for system libraries
-if test ! -f \$FREETYPE_LIBS; then
+if test ! -f "\$FREETYPE_LIBS"; then
   FREETYPE_LIBS="\`\$ft_config --libs\`"
 fi

EOF
echo "fix-ftlib.patch" >> debian/patches/series


# debuild -us -uc
debuild -us -uc -S
cd ..
cp ttfautohint_0.97-1.dsc ttfautohint-xUbuntu_16.04.dsc
cp -v ttfautohint-xUbuntu_16.04.dsc ttfautohint_0.97-1.debian.tar.gz ~/projects/science\:openturns/ttfautohint
