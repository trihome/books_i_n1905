# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and is restricted to
# this project.
import Config
# ログレベル
config :logger,
  level: :debug,
  compile_time_purge_matching: [
    [level_lower_than: :debug]
  ]

# TzData自動アップデートの無効化
config :tzdata, :autoupdate, :disabled

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :ex_app, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1671462577"

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

# hotswap有効化
config :mix_tasks_upload_hotswap,
  app_name: :ex_app,
  nodes: [:"ex_app@nerves.local"],
  # パスフレーズは任意に設定します
  cookie: :secrettoken

# 定期実行スケジュール
config :ex_app, ExApp.Scheduler,
  jobs: [
    # 一時間ごとに実行
    {"* * * * *", {ExApp, :oneshot, []}}
  ]
