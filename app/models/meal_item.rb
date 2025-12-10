class MealItem < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :my_menu

  enum :genre, { main: 1, side: 2, soup: 3, staple: 4, other: 5 }
end
