class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :uuid
      t.string :title
      t.string :author
      t.integer :year
      t.integer :shelf_id
      t.boolean :processed
      t.string :archive_org_id
      t.string :google_id
      t.integer :wordcount
      t.string :md5

      t.timestamps
    end
  end
end
