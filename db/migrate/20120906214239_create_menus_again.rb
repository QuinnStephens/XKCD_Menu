class CreateMenusAgain < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :total
      t.text :items

      t.timestamps
    end
  end
end