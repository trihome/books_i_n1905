defmodule Csv do
  @moduledoc """
  Documentation for `Csv`.
  """
  require Logger

  # デフォルトのcsvファイル名
  @path_w "/data/datalog.csv"

  @doc """
  write to file
  """
  def append(data, filepath \\ @path_w) do
    # ファイルを"追記append"で開いて書き込み
    File.write(filepath, data, [:append])
    # 書き込み内容を表示
    Logger.info(" - CSV write: [#{filepath}] #{data}")
  end

  defp tocsvformat(datetime, light, temp, humi) do
    # 引数の値を、CSV形式の文字の並びになるよう連結
    "#{datetime},#{light},#{temp},#{humi}\n"
  end

  @doc """
  write to file
  """
  def appendcsv(datetime, light, temp, humi, filepath \\ @path_w) do
    # CSV形式の文字の並びに変換して、CSVファイルに追記
    tocsvformat(datetime, light, temp, humi)
    |> append(filepath)

    # ↑"|>"の記号は、前の行の関数の戻り値を、次の行の関数の第1引数に与えます
  end
end
