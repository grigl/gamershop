class RenameProductNameToTitle < ActiveRecord::Migration
  def up
    rename_column :products, :name, :title
  end

  def down
  end
end
