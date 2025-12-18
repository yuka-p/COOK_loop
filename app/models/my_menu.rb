class MyMenu < ApplicationRecord
  belongs_to :user
  belongs_to :master_menu, optional: true

  has_many :meal_items, dependent: :destroy
  has_many :my_menu_tags, dependent: :destroy
  has_many :tags, through: :my_menu_tags

  validates :title, presence: true, length: { maximum: 15 }
  validates :genre, presence: true

  enum :genre, { main: 1, side: 2, soup: 3, staple: 4, other: 5 }

  # ▼ 単体表示用（例：一覧、home画面）
  def genre_i18n
    I18n.t("enums.my_menu.genre.#{genre}")
  end

  # ▼ 全ジャンルの日本語マップ（{"main"=>"主菜", ...}）
  def self.genres_i18n
    genres.keys.index_with { |g| I18n.t("enums.my_menu.genre.#{g}") }
  end

  # ▼ select 用（[[主菜, main], ...]）
  def self.genre_options
    genres_i18n.map { |key, label| [ label, key ] }
  end

  # ▼ ジャンル絞り込み
  scope :by_genre, ->(genre) {
    genres.key?(genre) ? where(genre: genre) : all
  }

  # ▼ 並び替え
  scope :sorted, ->(sort) {
    case sort
    when "created_desc"
      order(created_at: :desc)
    when "last_cooked_desc"
      order(last_cooked_at: :desc)
    when "title_asc"
      order(title: :asc)
    else
      all
    end
  }

  # 複数タグを文字列で受け取る
  attr_accessor :tag_names

  after_commit :assign_tags_from_names, on: %i[create update]

  private

  def assign_tags_from_names
    return if tag_names.blank?

    names = tag_names.split(/[,、\s]+/).map(&:strip).reject(&:blank?)

    # find_or_create_by で重複を避けつつタグを紐付け
    self.tags = names.map { |name| Tag.find_or_create_by(name:) }
  end
end
