class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.float :total
      t.text :items

      t.timestamps
    end
  end
end
