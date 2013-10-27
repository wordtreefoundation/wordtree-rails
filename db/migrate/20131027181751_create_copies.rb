class CreateCopies < ActiveRecord::Migration
  def change
    create_table :copies do |t|
      t.integer :shelf_id
      t.integer :book_id

      t.timestamps
    end
  end
end
