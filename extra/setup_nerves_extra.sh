proj_top=`pwd`/..

# setup deb packages
wget -nc http://ftp.jp.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo-dev_1.5.2-2+b1_armel.deb
dpkg -x libjpeg62-turbo-dev_1.5.2-2+b1_armel.deb .

wget -nc http://ftp.jp.debian.org/debian/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.5.2-2+b1_armel.deb
dpkg -x libjpeg62-turbo_1.5.2-2+b1_armel.deb .

wget -nc http://ftp.jp.debian.org/debian/pool/main/c/cimg/cimg-dev_2.4.5+dfsg-1_all.deb
dpkg -x cimg-dev_2.4.5+dfsg-1_all.deb .

wget -nc http://ftp.jp.debian.org/debian/pool/main/n/nlohmann-json3/nlohmann-json3-dev_3.5.0-0.1_all.deb
dpkg -x nlohmann-json3-dev_3.5.0-0.1_all.deb .

mkdir -p ${proj_top}/rootfs_overlay/usr/lib
cp -a usr/lib/arm-linux-gnueabi/libjpeg.so* ${proj_top}/rootfs_overlay/usr/lib

# setup tensorflow lite
git clone https://github.com/tensorflow/tensorflow.git tensorflow_src
pushd tensorflow_src
./tensorflow/lite/tools/make/download_dependencies.sh

cp -a ../nerves_makefile.inc ./tensorflow/lite/tools/make/targets
cp -a ../build_nerves_lib.sh ./tensorflow/lite/tools/make

./tensorflow/lite/tools/make/build_nerves_lib.sh

popd

