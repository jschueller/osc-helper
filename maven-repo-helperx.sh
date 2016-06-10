#!/bin/sh

set -e

cd /tmp
rm -rf maven-repo-helperx
mkdir -p maven-repo-helperx
cd maven-repo-helperx

wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/maven-repo-helper/maven-repo-helper_1.8.12.dsc
wget -c http://archive.ubuntu.com/ubuntu/pool/universe/m/maven-repo-helper/maven-repo-helper_1.8.12.tar.xz

dpkg-source -x maven-repo-helper_1.8.12.dsc

# cd javatools_0.54ubuntu1
cd maven-repo-helper-1.8.12
# nothing provides gcj-jdk
# sed -i "/libtest-minimumversion-perl/d" debian/control
# sed -i "/libtest-perl-critic-perl/d" debian/control
# sed -i "/libtest-strict-perl/d" debian/control
sed -i "s|ant-optional, libstax-java, junit4, libxmlunit-java, libcommons-io-java|javatools|g" debian/control

# sed -i "s|@gcc_suffix@//|@gcc_suffix@/-5/|g" debian/rules

debuild -us -uc -S
cd ..
cp maven-repo-helper_1.8.12.dsc maven-repo-helper-xUbuntu_16.04.dsc
cp maven-repo-helper-xUbuntu_16.04.dsc maven-repo-helper_1.8.12.tar.gz ~/projects/science\:openturns/maven-repo-helper

