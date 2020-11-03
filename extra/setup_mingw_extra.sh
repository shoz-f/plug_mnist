proj_top=`pwd`/..

# setup depend packages
if [ ! -e ./CImg_latest.zip ]
then
    wget -nc http://cimg.eu/files/CImg_latest.zip
    unzip CImg_latest.zip
    mkdir -p usr/include
    cp    CImg-*/CImg.h  usr/include
    cp -r CImg-*/plugins usr/include
fi

# setup tensorflow lite
git clone https://github.com/tensorflow/tensorflow.git tensorflow_src

pushd tensorflow_src
tfl_make=./tensorflow/lite/tools/make

if [ ! -e ${tfl_make}/downloads ]
then
    ${tfl_make}/download_dependencies.sh
fi

${tfl_make}/build_lib.sh

popd

