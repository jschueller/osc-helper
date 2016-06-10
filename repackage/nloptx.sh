#!/bin/sh

set -e

cd /tmp
rm -rf nloptx
mkdir -p nloptx
cd nloptx

# trusty

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.1+dfsg-1ubuntu1.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.1+dfsg.orig.tar.gz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.1+dfsg-1ubuntu1.debian.tar.gz

dpkg-source -x nlopt_2.4.1+dfsg-1ubuntu1.dsc

cd nlopt-2.4.1+dfsg
# nothing provides octave
sed -i "s|, octave-pkg-dev (>= 1.0.1)||g" debian/control
sed -i "84,102d" debian/control
sed -i "s|octave-nlopt python-nlopt|python-nlopt|g" debian/rules
sed -i "69,71d" debian/rules
sed -i "56,57d" debian/rules
sed -i "9,10d" debian/rules
rm debian/octave-nlopt.*

# debuild -us -uc
debuild -us -uc -S


cd ..
cp nlopt_2.4.1+dfsg-1ubuntu1.dsc nlopt-xUbuntu_14.04.dsc
cp nlopt-xUbuntu_14.04.dsc nlopt_2.4.1+dfsg-1ubuntu1.debian.tar.gz ~/projects/science\:openturns/nlopt





# xenial

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.2+dfsg-2.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.2+dfsg.orig.tar.gz
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/n/nlopt/nlopt_2.4.2+dfsg-2.debian.tar.xz

dpkg-source -x nlopt_2.4.2+dfsg-2.dsc
cd nlopt-2.4.2+dfsg


# nothing provides octave
sed -i "s|, octave-pkg-dev (>= 1.0.1)||g" debian/control
sed -i "84,102d" debian/control
sed -i "s|octave-nlopt python-nlopt|python-nlopt|g" debian/rules
sed -i "69,71d" debian/rules
sed -i "56,57d" debian/rules
sed -i "9,10d" debian/rules
rm debian/octave-nlopt.*

# debuild -us -uc
debuild -us -uc -S

cd ..
cp nlopt_2.4.2+dfsg-2.dsc nlopt-xUbuntu_16.04.dsc
cp nlopt-xUbuntu_16.04.dsc nlopt_2.4.2+dfsg-2.debian.tar.xz ~/projects/science\:openturns/nlopt
