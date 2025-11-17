class MasterMenu < ApplicationRecord
  has_many :my_menus

  validates :title, presence: true, length: { maximum: 15 }
  validates :genre, presence: true, inclusion: { in: [ 1, 2, 3 ] }
end
