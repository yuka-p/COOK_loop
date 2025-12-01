class DropUserGenresTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :user_genres
  end

  def down
    create_table :user_genres do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :position
      t.timestamps
    end
  end
end