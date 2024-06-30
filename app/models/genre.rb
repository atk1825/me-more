class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name:'---'},
    { id: 2, name:'生物' },
    { id: 3, name:'科学'},
    { id: 4, name:'歴史'},
    { id: 5, name:'社会'},
    { id: 6, name:'数学'},
    { id: 7, name:'雑学'},
    { id: 8, name:'その他'}
  ]

  include ActiveHash::Associations
  has_many :posts

end