class AddPositionToUserGenres < ActiveRecord::Migration[7.2]
  def change
    add_column :user_genres, :position, :integer
  end
end
