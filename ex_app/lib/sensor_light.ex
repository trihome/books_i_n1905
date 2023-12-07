defmodule SensorLight do
  @moduledoc """
  Documentation for `SensorLight`.
  """
  require Logger

  def get() do
    # ADコンバータ0chの電圧値を取得
    data = GroveBasehatAdc.read_voltage(0)
    # 測定結果を表示
    Logger.info(" - Light: #{data}")
    # 結果を返す
    data
  end
end
