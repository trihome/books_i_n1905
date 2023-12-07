defmodule LineNotify do
  @moduledoc """
  Documentation for `LineNotify`.
  """
  require Logger

  @url "https://notify-api.line.me/api/notify"
  @access_token "(アクセストークンを代入)"
  @headers [Authorization: "Bearer #{@access_token}"]

  def send(message) do
    HTTPoison.post(@url, {:form, [message: message]}, @headers)
    # 送信内容を表示
    Logger.info(" - LineNotify: #{message}")
  end
end
