class MyMenu < ApplicationRecord
  belongs_to :user
  belongs_to :master_menu, optional: true
  belongs_to :genre, class_name: "UserGenre", foreign_key: "genre_id"

  has_many :meal_items, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
  validates :genre, presence: true

  enum genre: { main: 1, side: 2, soup: 3, staple: 4 }

  def genre_i18n
    I18n.t("activerecord.attributes.my_menu.genres.#{genre}")
  end
end
