defmodule PlugMnist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugMnist.Router, options: [port: 5000]},
      {PlugMnist.TflInterp, [model: "priv/mnist.tfl"]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlugMnist.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
