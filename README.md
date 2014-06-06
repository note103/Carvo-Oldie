Carvo
=====

Cards of vocabulary

## 説明

- 英単語学習のためのプログラムです。
- 英単語が出てきたら日本語を、日本語が出てきたら英単語を打ち込みます。

## DEMO

![](https://dl.dropboxusercontent.com/u/7779513/github/gif/Carvo-demo2.gif)

## 使い方

1. 任意の場所にディレクトリを置いて中に入り、
```
$ cd Carvo
```

1. ターミナルで`practice.pl`を実行します。
```
$ perl practice.pl
```

1. `Input...`と出てくるので、下記に沿って`e`,`e2`,`j`,`j2`のいずれかを入力＆エンターするとレッスンが始まります（選択せずにエンターすると自動的に`e`を選択します）。
  - **e**: 英単語が出てくるので日本語を答えるモード
  - **e2**: 同モードで単語の数が多い
  - **j**: 日本語が出てくるので英単語を答えるモード
  - **j2**: 同モードで単語の数が多い

1. 単語が出てくるので、そのままターミナルに回答（英単語に対する日本語、日本語に対する逆）を打ち込むと、`NG!`または`OK!`と出てきます。

1. レッスン開始直後、または`NG!`, `OK!`が出た後に任意の数字を入れると、その番号に紐付いた単語が出てきます。
  - 登録単語以上の数字（番号）は受け付けません。上限はレッスン開始直後に表示されます。
  - 何も入力せずにエンターすると、1番からスタートします。以後も正解またはギブアップ（後述の`q`コマンド）の後にエンターを入力すると次の番号の単語が出てきます。
  - 正解もギブアップもしない状態で未入力のままエンターした場合には「Again!」と出て回答を求めます。

1. レッスン開始直後、または`NG!`, `OK!`が出た後に以下のコマンドを入力すると、それぞれの動作をします。
  - **s**: 直前に出た単語をもう一度出します。
  - **r**: ランダムに単語を出力します（これを使用しなければ常に番号順に出力します）。
  - **q**: レッスンのループから抜けます。

1. レッスン終了後、もう一度`q`を入力するとプログラムも終了します。

## サンプルデータについて

- dataディレクトリ内のJSONファイルは公開用サンプルデータのため、あまり多くは入っていません。実際には大量のデータを入れた方が面白い＆勉強になります。
- どこかに再配布可能なデータがあれば今後はそういう物を使うかもしれません。

## TODO

- どの階層にいても`qq`で終了するようにしたい
- ランダム設定のときに日英混在で出てくるようにしたい
- 実行時に書き込み（単語の新規登録）もできるようにしたい
- ブラウザで実行できるようにしたい（Webアプリ化）
- 実行（レッスン）した内容を記録・保管しておけるようにしたい
  - データベース必須か
- 正答したら得点が加算されるようにしたい
  - プログラム終了するたびにリセット＆記録保管とか
- スマホから実行できるようにしたい（モバイルアプリ化）

## 作者

Hiroaki Kadomatsu (@note103)

- [Blog](http://note103.hateblo.jp/)
- [Twitter](https://twitter.com/note103)
