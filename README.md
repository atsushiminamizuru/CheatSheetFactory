# アプリケーション名
Cheat Sheet Factory

# アプリケーション概要
プログラミング学習で作ったチートシートを共有することで、登録ユーザーの生産性を向上させる。<br>
ユーザー同士でコミュニケーションをとることで、学習へのモチベーションを上げることができる。

# URL
https://cheat-sheet-factory.onrender.com

# テスト用アカウント
ゲストログイン（閲覧用）機能実装

# 利用方法
### チートシート投稿
1.トップページの「ユーザー新規登録ボタン」から専用フォーム画面へ遷移し、ユーザー新規登録を行う<br>
2.新規投稿ボタンから、チートシートの内容（画像、言語、タイトル、内容）を入力し投稿する

### 他者を励ます
1.投稿一覧ページから、タイトルをクリックして詳細を確認する<br>
2.役立った投稿があれば、ユーザーのフォロー・投稿内容のお気に入り・コメントでメッセージを送るなどを行う

# アプリケーションを作成した背景
プログラミング学習をする中で自分の備忘用にプログラミングノートを作成していた。<br>
Qiitaでも内容共有はできるが、他者に見てもらうことに重点が置かれている為、投稿するにあたりハードルが高いと感じた。<br>
気軽に投稿できることや、自分の資料管理にも利用できることから、本アプリケーションの開発を行うことにした。

# 洗い出した要件
[要件を定義したシート](https://docs.google.com/spreadsheets/d/1-sXuzokYmxBdQ--xWK8LSFCrU1SGd6tXFrVTq3U7EQE/edit?usp=sharing)

# 実装した主な機能
・ゲストログイン機能<br>
・デバイスユーザー機能<br>
・画像投稿機能（別タブ表示機能/ダウンロード機能）<br>
・投稿検索機能<br>
・コメント機能、いいね機能、フォロー機能<br>
・非同期通信（いいね機能、フォロー機能）<br>
・ページネーション機能<br>
・フラッシュメッセージ、エラーメッセージ

# アプリケーションの動画(クリックでリンク先に遷移)
[![Image from Gyazo](https://i.gyazo.com/7861f8c46b3fe1315c8acd3f891c790b.gif)](https://gyazo.com/7861f8c46b3fe1315c8acd3f891c790b)

# 実装予定の機能
・検索機能/コメント機能への非同期通信を実装予定<br>
・チートシートをベースにQiitaに投稿したものがあれば、投稿の詳細画面に解説として表示できるようQiitaのAPIを実装予定

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/b030fdbbbb583b74e057e5cd6a4bddcd.png)](https://gyazo.com/b030fdbbbb583b74e057e5cd6a4bddcd)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/18991f11a7da3f339439fd1756ca8bad.png)](https://gyazo.com/18991f11a7da3f339439fd1756ca8bad)

# 開発環境
・IDE：Cloud9<br>
・フロントエンド：Bootstorap4.5.2<br>
・バックエンド：Ruby3.1.2/Rails6.1.7<br>
・デプロイ：Render.com<br>
・テスト：Rspecによるモデル単体テスト<br>
・ページネーション：kaminari1.2.1

# ローカルでの動作方法
% git clone https://github.com/atsushiminamizuru/CheatSheetFactory.git<br>
% cd CheatSheetFactory<br>
% bundle install<br>
% yarn install

# 工夫したポイント
### 画像を含めたN＋1問題の発生を防いだ点
・「@sheet.user」を「@user」とする等、コントローラーでインスタンス変数を用意することで不必要なテーブル跨ぎを回避したこと<br>
・countではなくsizeを使用し、COUNTのクエリの発生はページネーションを使うことで最小限に抑えたこと

### ユーザー視点で使いやすさを意識した点
・画面左上にログインユーザー情報を表示したこと<br>
・プロフィール画像や自己紹介について、ブランクの場合でもアプリを使用できるようにデフォルトで用意したこと<br>
・各画面でのリンクをつける項目とつけない項目をページ毎に変えたこと
