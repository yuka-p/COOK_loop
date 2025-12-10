class AddGenreToMealItems < ActiveRecord::Migration[7.2]
  def change
    add_column :meal_items, :genre, :integer, null: false, default: 1
  end
end
