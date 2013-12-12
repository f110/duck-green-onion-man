鴨ネギスクリプト
---

# 概要

メッセージを監視していい感じに通知します。

# 使い方

## インストール

    $ carton install

## 起動方法

    $ carton exec -- perl duck.pl

## おすすめ

    $ carton exec -- perl duck.pl --notify=notifo --message_open

# オプション

## --growl -g

新しいメッセージがあったらGrowl通知をします。

growlnotifyコマンドがパスが通ったディレクトリにインストールされている必要があります。

## --notify -n

通知をスマートフォンに送ります．growlフラグとは関係ありません．

対応サービスはim.kayac.comとnotifoです．

im.kayac.comを使う場合は以下のようにします．

    $ carton exec -- perl duck.pl --notify "kayac"

notifoを使う場合は以下のようにします．

    $ carton exec -- perl duck.pl --notify "notifo"

im.kayac.comはiPhoneのみ．notifoもstableではiPhoneのみですが，Androidアプリも存在し
Androidへ通知を送る事も出来ます．

いずれのサービスを使う場合でもそれぞれのサイトで登録をしAPIを使える状態にする必要があります．

[im.kayac](http://im.kayac.com/)

[notifo](http://notifo.com/)

im.kayac.comの場合は登録したユーザー名をconfigファイルへ記述，
notifoの場合はユーザー名とAPI Secretをconfigファイルへ書く必要があります．

im.kayac.comは同時に複数のデバイスでSubscribeした場合は，後にログインした方のみに通知が飛びます．
notifoは複数のデバイスでSubscribeした場合でもそれぞれのデバイスへ通知が飛びます．

## --message-open -m

自動で新着メッセージを開きます．自動でメッセージ内のURLを開くのが怖い人はこちらがオススメ．

## --hosts

configファイル内に書かれたドメインとIPの対応を使用します．
管理者権限がなく，hostsファイルが書き換えられない場合でもアクセスする事が出来るようになります．

## --port

WebフロントエンドがListenするポート番号を指定します．
デフォルトは **8800** です．

## --host

WebフロントエンドがListenするhost名を指定します．
特に理由がない限り指定する必要はありません．

## --no-watcher

監視スクリプトは起動しない．

## --no-web

Webフロントエンドは起動しない．

# GOAL

phantomjsと組み合わせ，自動採点

# MEMO

自宅でログイン試行しすぎたらBANされて解除されないorz
