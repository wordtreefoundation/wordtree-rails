class CreateArchiveOrgTransfers < ActiveRecord::Migration
  def change
    create_table :archive_org_transfers do |t|
      t.integer :user_id
      t.integer :shelf_id
      t.integer :min_year
      t.integer :max_year
      t.integer :per_page, :default => 50
      t.integer :current_page, :default => 0
      t.integer :total_pages

      t.timestamps
    end
  end
end
