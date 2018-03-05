class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.string :type
      t.text :body
      t.integer :sender
      t.boolean :read

      t.timestamps
    end
  end
end
