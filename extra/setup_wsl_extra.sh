proj_top=`pwd`/..

# setup tensorflow lite
git clone https://github.com/tensorflow/tensorflow.git tensorflow_src
pushd tensorflow_src
./tensorflow/lite/tools/make/download_dependencies.sh

./tensorflow/lite/tools/make/build_lib.sh

popd

