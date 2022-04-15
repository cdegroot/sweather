defmodule Sweather.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sweather.Supervisor]

    children =
      [
        {Plug.Cowboy, scheme: :http, plug: Sweather.Router, options: [port: 4000]}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Sweather.Worker.start_link(arg)
      # {Sweather.Worker, arg},
      {Sweather.FakeBMP280, name: Sweather.BMP280}
    ]
  end

  def children(target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Sweather.Worker.start_link(arg)
      # {Sweather.Worker, arg},
      {BPM280, bus_name: "i2c-1", bus_address: 0x76, name: Sweather.BMP280}
    ]
  end

  def target() do
    Application.get_env(:sweather, :target)
  end
end
