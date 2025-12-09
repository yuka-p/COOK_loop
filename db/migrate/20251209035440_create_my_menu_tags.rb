class CreateMyMenuTags < ActiveRecord::Migration[7.2]
  def change
    create_table :my_menu_tags do |t|
      t.references :my_menu, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
