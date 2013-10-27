class RemoveBooksShelfId < ActiveRecord::Migration
  def change
    remove_column :books, :shelf_id
  end
end
