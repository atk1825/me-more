# README
## users
| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| name               | string    | null: false               |
| age                | integer   | null: false               |
| email              | string    | null: false, unique: true |
| encrypted_password | string    | null: false               |

### Association
- has_many :posts


## posts
| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| title    | string     | null: false                    |
| content  | text       | null: false                    |
| genre_id | integer    | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association
- belongs_to :user