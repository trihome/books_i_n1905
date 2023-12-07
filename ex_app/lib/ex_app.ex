defmodule ExApp do
  @moduledoc """
  Documentation for ExApp.
  """
  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> ExApp.hello
      :world

  """
  def hello do
    :world
  end

  @gpio_led 16

  @doc """
  メインループ
  """
  def main() do
    # 測定
    oneshot()
    # 1時間待機(3600秒)
    Logger.info("待機中...")
    Process.sleep(60 * 60 * 1000)
    main()
  end

  @doc """
  一回分の作業
  """
  def oneshot() do
    # 日時の文字列を生成
    timenow =
      Timex.now("Asia/Tokyo")
      |> Timex.format!("{YYYY}/{M}/{D} {h24}:{m}:{s}")

    dt = "#{timenow}"
    Logger.info("測定中...[#{dt}]")
    {:ok, gpio} = Circuits.GPIO.open(@gpio_led, :output)
    # 測定中を示すLEDを点灯
    Circuits.GPIO.write(gpio, 1)
    # 明るさを測定
    light = SensorLight.get()
    # 温度湿度を測定
    {temp, humi} = SensorTehu.get()
    # CSVファイルに保存
    Csv.appendcsv(dt, light, temp, humi)
    # LINEに投稿
    LineNotify.send("Elixir\n Light: #{light}\n Temp: #{temp}deg\n Humi: #{humi}%")
    Process.sleep(1000)
    # LEDを消灯
    Circuits.GPIO.write(gpio, 0)
    Logger.info("測定完了.")
  end
end
