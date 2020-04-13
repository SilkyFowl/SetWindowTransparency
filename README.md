SetWindowTransparency
---

ウィンドウの透過度を操作するPowershellモジュールです。
UWP非対応。

## これは何？

指定したプロセスが保持するウィンドウの透過度を変更できます。
昔使っていたソフトがうまく動かなかったのでPowershellによる開発、リポジトリ管理の練習も兼ねて自作することにしました。

## 使い方

```pwsh
Import-Module .\SetWindowTransparency.psm1

# Set transparency 160
Get-Process notepad | Set-WindowTransparency 160

# Set transparency 255
Get-Process notepad | Set-WindowTransparency 255
```

## 開発環境

OS : Windows10
Powershell : v7.0

## ToDo

- [x] readmeの日本語化
- [ ] コメント付与
- [ ] Pesterによるテスト

## ライセンス

[MIT](https://github.com/SilkyFowl/SetWindowTransparency/blob/master/LICENSE)

## 作者

[SilkyFowl](https://github.com/SilkyFowl)