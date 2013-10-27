class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.integer :user_id
      t.integer :group_id
      t.integer :sample_size
      t.integer :book_id
      t.integer :minus_shelf_id
      t.integer :year_min
      t.integer :year_max
      t.integer :ngrams
      t.string :score_method
      t.integer :baseline_id
      t.boolean :published

      t.timestamps
    end
  end
end
