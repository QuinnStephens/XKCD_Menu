class ChangeNumberTypesForMenu < ActiveRecord::Migration
  def change
    change_column :menus, :items, :integer
  end

end
