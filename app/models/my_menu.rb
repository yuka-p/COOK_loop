class MyMenu < ApplicationRecord
  belongs_to :user
  belongs_to :master_menu, optional: true

  has_many :meal_items, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
  validates :genre, presence: true

  enum :genre, { main: 1, side: 2, soup: 3, staple: 4, other: 5 }

  def genre_i18n
    I18n.t("enums.my_menu.genre.#{genre}")
  end

  def self.genre_options
    distinct.pluck(:genre).map do |g|
      [I18n.t("enums.my_menu.genre.#{g}"), g]
    end
  end

  # ▼ ジャンル絞り込み
  scope :by_genre, ->(genre) {
    genre.present? ? where(genre: genre) : all
  }

  # ▼ 並び替え
  scope :sorted, ->(sort) {
    case sort
    when "last_cooked_desc"
      order(last_cooked_at: :desc)
    when "created_desc"
      order(created_at: :desc)
    when "title_asc"
      order(title: :asc)
    else
      all
    end
  }
end
