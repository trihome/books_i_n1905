defmodule ExApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExApp.Supervisor]

    # Loggerの常時表示を有効
    RingLogger.attach()

    children =
      [
        # Children for all targets
        # Starts a worker by calling: ExApp.Worker.start_link(arg)
        # {ExApp.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: ExApp.Worker.start_link(arg)
      # {ExApp.Worker, arg},
    ]
  end

  def children(_target) do
    # epmdを起動
    System.cmd("epmd", ["-daemon"])
    # ノードを有効化
    Node.start(:"ex_app@nerves.local")
    # パスフレーズを登録
    Node.set_cookie(Application.get_env(:mix_tasks_upload_hotswap, :cookie))

    [
      # Children for all targets except host
      # Starts a worker by calling: ExApp.Worker.start_link(arg)
      # {ExApp.Worker, arg},
      # ↓追記
      {ExApp.Scheduler, []}
    ]
  end

  def target() do
    Application.get_env(:ex_app, :target)
  end
end
