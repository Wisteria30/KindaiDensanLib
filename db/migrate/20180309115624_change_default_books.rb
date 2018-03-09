class ChangeDefaultBooks < ActiveRecord::Migration[5.1]
  def change
    change_column_null :books, :title, false

    change_column_null :books, :isbn, false
  end
end
