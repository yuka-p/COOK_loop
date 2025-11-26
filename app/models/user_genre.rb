class UserGenre < ApplicationRecord
  belongs_to :user
  has_many :my_menus, foreign_key: :genre_id, dependent: :nullify

  validates :name, presence: true, length: { maximum: 20 }
  validates :name, uniqueness: { scope: :user_id, message: "はすでに作成済みです" }

  acts_as_list scope: :user

end
