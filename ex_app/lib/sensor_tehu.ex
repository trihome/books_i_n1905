defmodule SensorTehu do
  @moduledoc """
  Documentation for `SensorTehu`.
  """
  require Logger

  def get() do
    # センサーの値を取得
    {:ok, {temp, humi}} = GroveAht20.read_from_aht20()
    # 測定結果を表示
    Logger.info(" - Temp: #{temp} degree, Humi: #{humi} %")
    # 結果を返す
    {temp, humi}
  end
end
