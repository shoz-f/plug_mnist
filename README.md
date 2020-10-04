# PlugMnist

MNIST application implemented in Elixir with Tensorflow lite.

## Platform
- Windows MSYS2/MinGW64

## Requirement

Following items are needed to build 'plug_mnist'. To store them under "C:/msys64/home/work".

- tensorflow_src: https://github.com/tensorflow/tensorflow.git
- CImg-2.9.2:     http://cimg.eu/download.shtml

Before building 'plug_mnist", you have to prepare 'libtensorflow-lite.a'.
To see https://qiita.com/ShozF/items/50d45b6234fa11da1a0d more detail.

## Getting start
You can get the plug_mnist app to invoke following command:

> mix deps
> mix compile

If your 'libtensorflow-lite.a' is stored to a different directory than the default,
you need to specify the root directory in the environment variable "WORK_HOME":

> set WORK_HOME=C:/msys64/home/other_root
> mix compile

After then, you run the app:

> mix run --no-halt

and connect BROWSER to "http://localhost:5000"

enjoy!
