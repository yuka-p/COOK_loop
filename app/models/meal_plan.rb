class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meal_items, dependent: :destroy
  has_many :my_menus, through: :meal_items
end
