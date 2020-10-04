defmodule PlugMnist.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_mnist,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
 
      make_executable: "make",  # Invoke MinGW64 make
      compilers: [:elixir_make] ++ Mix.compilers
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PlugMnist.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:plug_static_index_html, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:elixir_make, "~> 0.4", runtime: false},
    ]
  end
end
