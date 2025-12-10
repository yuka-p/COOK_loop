class MealItem < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :my_menu

  enum category: { main: 0, side: 1 }
end
