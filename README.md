# アプリケーション名
Cheat Sheet Factory

# アプリケーション概要
プログラミング学習で作ったチートシートを共有することで、登録ユーザーの生産性を向上させる。<br>
ユーザー同士でコミュニケーションをとることで、学習へのモチベーションを上げることができる。

# URL

# テスト用アカウント

# 利用方法
### チートシート投稿
1.トップページの「ユーザー新規登録ボタン」から専用フォーム画面へ遷移し、ユーザー新規登録を行う<br>
2.新規投稿ボタンから、チートシートの内容（画像、タイトル、説明、言語）を入力し投稿する

### 他者を励ます
1.投稿一覧ページから、タイトルをクリックして詳細を確認する<br>
2.役立った投稿があれば、ユーザーのフォロー・投稿内容のお気に入り・コメントでメッセージを送るなどを行う

# アプリケーションを作成した背景
プログラミング学習をする中で自分の備忘用にプログラミングノートを作成していた。<br>
Qiitaでも内容共有はできるが、他者に見てもらうことに重点が置かれている為、投稿するにあたりハードルが高いと感じた。<br>
気軽に投稿できることや、自分の資料管理にも利用できることから、本アプリケーションの開発をすることにした。

# 洗い出した要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1-sXuzokYmxBdQ--xWK8LSFCrU1SGd6tXFrVTq3U7EQE/edit?usp=sharing)

# 自走した機能についての画像やGIFおよびその説明

# 実装予定の機能
チートシートをベースにQiitaに投稿したものがあれば、投稿の詳細画面に解説として表示できるようQiitaのAPIを導入する予定

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/b030fdbbbb583b74e057e5cd6a4bddcd.png)](https://gyazo.com/b030fdbbbb583b74e057e5cd6a4bddcd)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/db7c38c072837261a3f585afea163c9a.png)](https://gyazo.com/db7c38c072837261a3f585afea163c9a)

# 開発環境
・フロントエンド<br>
・バックエンド<br>
・インフラ<br>
・テスト<br>
・テキストエディタ<br>

# ローカルでの動作方法
% git clone https://github.com/atsushiminamizuru/original_app.git<br>
% cd original_app<br>
% bundle install<br>
% yarn install

# 工夫したポイント
