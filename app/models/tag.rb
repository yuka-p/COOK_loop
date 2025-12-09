class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :my_menu_tags, dependent: :destroy
  has_many :my_menus, through: :my_menu_tags
end
