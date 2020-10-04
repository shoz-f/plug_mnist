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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `plug_mnist` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:plug_mnist, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/plug_mnist](https://hexdocs.pm/plug_mnist).

