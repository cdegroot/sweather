defmodule Sweather.Router do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    resp(conn, 200, "OK")
  end

  get "/metrics" do
    # As long as we only have one call, might as well keep it inline.
    {:ok, measurement} = BMP280.measure(Sweather.BMP280)
    response =
      gauge("temperature", measurement.temperature_c, "Temperature in Celsius") <>
      gauge("dew_point_c", measurement.dew_point_c, "Dew point in Celsius") <>
      gauge("humidity_rh", measurement.humidity_rh, "Relative humidity") <>
      gauge("pressure_pa", measurement.pressure_pa, "Pressure in Pascal")
    resp(conn, 200, response)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp gauge(name, value, text) do
    """
    # HELP #{name} #{text}
    # TYPE #{name} gauge
    #{name} #{value}
    """
  end
 end
