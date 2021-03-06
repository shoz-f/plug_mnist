proj_top=`pwd`/..

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

