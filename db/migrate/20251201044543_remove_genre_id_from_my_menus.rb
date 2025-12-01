class RemoveGenreIdFromMyMenus < ActiveRecord::Migration[7.2]
  def change
    remove_column :my_menus, :genre_id, :bigint
  end
end
