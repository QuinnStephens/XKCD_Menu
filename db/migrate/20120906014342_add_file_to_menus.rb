class AddFileToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :file, :file
  end
end
