class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.integer :query_id
      t.integer :book_id
      t.float :score
      t.float :priority

      t.timestamps
    end
  end
end
