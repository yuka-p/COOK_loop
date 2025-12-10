class AddCategoryToMealItems < ActiveRecord::Migration[7.2]
  def change
    add_column :meal_items, :category, :integer, null: false, default: 0
  end
end
