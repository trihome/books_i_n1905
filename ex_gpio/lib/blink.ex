defmodule Blink do
  @moduledoc """
  Documentation for `Blink`.
  """
  def blink do
    # 16番ピンを使う
    gpio16 = 16
    {:ok, gpio} = Circuits.GPIO.open(gpio16, :output)
    # 5回繰り返し
    for _ <- 0..5 do
      # 0.2秒停止
      Process.sleep(200)
      # 点灯
      Circuits.GPIO.write(gpio, 1)
      Process.sleep(200)
      # 消灯
      Circuits.GPIO.write(gpio, 0)
    end

    Circuits.GPIO.close(gpio)
  end
end
