defmodule ExGpio do
  @moduledoc """
  Documentation for ExGpio.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExGpio.hello
      :world

  """
  def hello do
    :world
  end

  def main do
    IO.puts("elixir running...")
    # 処理関数を呼び出し
    Blink.blink()
    IO.puts("elixir done.")
  end
end
