# アプリケーション名
 me-more

# アプリケーション概要
 アウトプットとインプットを両立し、新しい知識を得ることができる

# URL

# テスト用アカウント

# 利用方法
## アウトプット投稿
* ユーザー登録をする
* 投稿ボタンから必要な項目を書いて投稿する
* 他社のアウトプットが表示されるので、気に入ったのがあれば保存する

## 学習定着
* マイページにあるアウトプットした内容を１、３、７日後ごとに確認することできる

# アプリケーションを作成した背景
 学生や社会人が効率よく学習することができるアプリケーション

# 実装した機能についての画像やGIFおよびその説明
# 実装予定の機能
# データベース設計
[![Image from Gyazo](https://i.gyazo.com/36c73673f2c9e1e22fd21badc06acfbe.png)](https://gyazo.com/36c73673f2c9e1e22fd21badc06acfbe)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/c32b246fee8ec6da2d17e20173811c57.png)](https://gyazo.com/c32b246fee8ec6da2d17e20173811c57)
# 開発環境
# ローカルでの動作方法
# 工夫したポイント
# 改善点
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