class RenameStatusColumnInOrder < ActiveRecord::Migration
  def up
    rename_column :orders, :status, :pay_status
  end

  def down
  end
end
