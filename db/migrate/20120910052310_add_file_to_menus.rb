class AddFileToMenus < ActiveRecord::Migration
  def up
    add_column :menus, :file, :string
  end

  def down
    remove_column :menus, :file
  end
end
