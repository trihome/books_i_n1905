# サポートページ「ElixirではじめるIoT開発入門」

## サンプルコードのビルドを試す手順

Nerves開発環境のインストールが完了しているものとします。

```sh
$ git clone https://github.com/trihome/books_i_n1905.git

$ cd books_i_n1905/ex_gpio

# 対象デバイスを環境変数に定義（例は Raspberry Pi 4）
$ export MIX_TARGET=rpi4

# ビルド（初回は数分～十数分程度かかります）
$ mix deps.get && mix firmware
Resolving Hex dependencies...
・・・
Generated ex_gpio app
|nerves| Building OTP Release...

* [Nerves] validating vm.args
* skipping runtime configuration (config/runtime.exs not found)
* creating _build/rpi4_dev/rel/ex_gpio/releases/0.1.0/vm.args
Updating base firmware image with Erlang release...
Copying rootfs_overlay: /home/myasu/gitwork/books_i_n1905/ex_gpio/_build/rpi4_dev/nerves/rootfs_overlay
Copying rootfs_overlay: /home/myasu/gitwork/books_i_n1905/ex_gpio/rootfs_overlay
Building /home/myasu/gitwork/books_i_n1905/ex_gpio/_build/rpi4_dev/nerves/images/ex_gpio.fw...
Firmware built successfully! 🎉

Now you may install it to a MicroSD card using `mix burn` or upload it
to a device with `mix upload` or `mix firmware.gen.script`+`./upload.sh`.
```

---
[README.md](./README.md)
