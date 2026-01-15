class MasterMenu < ApplicationRecord
  enum :genre, { main: 1, side: 2, soup: 3, staple: 4, other: 5 }
  has_many :my_menus

  validates :title, presence: true, length: { maximum: 15 }
  validates :genre, presence: true, inclusion: { in: genres.keys }

  def genre_i18n
    I18n.t("enums.master_menu.genre.#{genre}")
  end

  def self.genres_i18n
    genres.keys.index_with { |g| I18n.t("enums.master_menu.genre.#{g}") }
  end
end
