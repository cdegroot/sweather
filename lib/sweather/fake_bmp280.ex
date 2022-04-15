defmodule Sweather.FakeBMP280 do
  @moduledoc """
  Fake implementation for the BMP280 module to use on host
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_args) do
    {:ok, nil}
  end

  def handle_call(:measure, _from, state) do
    reply = %{
      temperature_c: 21.0,
      dew_point_c: 9.0,
      humidity_rh: 45.0,
      pressure_pa: 960.0
    }
    {:reply, {:ok, reply}, state}
  end
end
