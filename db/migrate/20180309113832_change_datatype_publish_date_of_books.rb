class ChangeDatatypePublishDateOfBooks < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :publish_date, :string
  end
end
