class RenameTypeColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :notices, :type, :title
  end
end
