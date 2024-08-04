# アプリケーション名
 me-more

# アプリケーション概要
 アウトプットとインプットを両立し、新しい知識を得ることができる

# URL
https://me-more.onrender.com/

# テスト用アカウント
* メールアドレス：test@com
* パスワード:aaa111

# 利用方法
## アウトプット投稿
* ユーザー登録をする
* 投稿ボタンから必要な項目を書いて投稿する
* 他人のアウトプットが表示されるので、気に入ったのがあれば保存する
## 学習機能
* 1日前、3日前、7日前の投稿が表示されて忘れかけた頃に見返すことで記憶の定着に繋がる
* 保存した投稿欄から他人のアウトプットを見ることができる

## 学習定着
* マイページにあるアウトプットした内容を１、３、７日後ごとにチャットGPTを活用して、問題を解きながら確認することできる

# アプリケーションを作成した背景
 学生や社会人が効率よく学習することができるアプリケーション

# 実装した機能についての画像やGIFおよびその説明


# 実装予定の機能
* 投稿機能に画像を添付できるようにする
* プレビューもできるようにする
* チャットGPTを使い、アウトプットの内容を問題形式で表示できるようにする

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/36c73673f2c9e1e22fd21badc06acfbe.png)](https://gyazo.com/36c73673f2c9e1e22fd21badc06acfbe)

# 画面遷移図
[![Image from Gyazo](https://gyazo.com/9cfa84f2a50d03bde014bcc9ca6a33d1)
# 開発環境
*フロントエンド
*バックエンド
*インフラ
*テスト
*テキストエディタ
*タスク管理

# ローカルでの動作方法
以下のコマンドを順に実行
% git clone https://github.com/atk1825/me-more
% cd me-more
% bundle install

# 工夫したポイント
*画面内に説明の文章を書くことなく直感的に扱えるようにした

# 改善点
*チャットGPTに問題を作成してもらう内容をより、パーソナライズ化する
*配色が自分の好みのものにしたので、ユーザーの使いやすい配色にする
# 製作時間




## users
| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| name               | string    | null: false               |
| age                | integer   | null: false               |
| email              | string    | null: false, unique: true |
| encrypted_password | string    | null: false               |

### Association
- has_many :posts
- has_many :likes


## posts
| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| title    | string     | null: false                    |
| content  | text       | null: false                    |
| genre_id | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :likes


## likes
| Column  | Type       | Options
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| post_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post