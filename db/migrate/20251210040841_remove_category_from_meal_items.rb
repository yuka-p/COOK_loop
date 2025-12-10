class RemoveCategoryFromMealItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :meal_items, :category, :integer
  end
end
