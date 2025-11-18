class AddGenreIdToMyMenus < ActiveRecord::Migration[7.2]
  def change
    add_reference :my_menus, :genre, foreign_key: { to_table: :user_genres }, index: true
  end
end
