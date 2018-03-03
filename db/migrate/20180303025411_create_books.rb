class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.integer :publish_date
      t.string :genre
      t.string :isbn
      t.boolean :status
      t.string :rental_user

      t.timestamps
    end
  end
end
