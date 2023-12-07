defmodule GroveBasehatAdc do
  @moduledoc """
  Documentation for `GroveBasehatAdc`.

  https://github.com/elixir-circuits/circuits_i2c
  https://github.com/Seeed-Studio/grove.py/blob/master/grove/adc.py
  """
  alias Circuits.I2C
  require Logger
  use Bitwise

  @bus "i2c-1"
  # I2Cアドレス
  @address 0x04

  @doc """
  12bitアナログ入力のRAWデータを読み込み
  ## Parameter
    - channel (int): 0 - 7, specify the channel to read
  ## Return:
    - (int): the adc result, in [0 - 4095]
  """
  def read_raw(channel) do
    # I2Cを開く
    {:ok, ref} = I2C.open(@bus)
    # 指定のレジスタを読み込み
    regaddr = 0x10 + channel
    read_register2(ref, regaddr)
  end

  @doc """
  電圧(mV)変換した値を返す
  ## Parameter
    - channel (int): 0 - 7, specify the channel to read
  ## Return:
    - (int): the voltage result, in mV
  """
  def read_voltage(channel) do
    # I2Cを開く
    {:ok, ref} = I2C.open(@bus)
    # 指定のレジスタを読み込み
    regaddr = 0x20 + channel
    read_register2(ref, regaddr)
  end

  @doc """
  I2Cレジスタの読み出し(8bit)
  ## Parameter
    - ref : i2c id
    - n (int): I2C Resister Addr
  ## Return:
  """
  def read_register(ref, n) do
    I2C.write(ref, @address, <<n>>)
    Process.sleep(1)
    {:ok, <<ret>>} = I2C.read(ref, @address, 1)
    ret
  end

  @doc """
  I2Cレジスタの読み出し(12bit)
  """
  def read_register2(ref, n) do
    I2C.write(ref, @address, <<n>>)
    Process.sleep(1)
    I2C.read(ref, @address, 2)
    {:ok, <<ret0, ret1>>} = I2C.read(ref, @address, 2)
    # 2バイト分の値をビットシフトして連結
    ret0 ||| ret1 <<< 8
  end
end
