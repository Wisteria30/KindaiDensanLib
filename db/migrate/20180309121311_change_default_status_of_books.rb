class ChangeDefaultStatusOfBooks < ActiveRecord::Migration[5.1]
  def change
    change_column_default :books, :status, true
  end
end
