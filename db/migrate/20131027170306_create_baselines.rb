class CreateBaselines < ActiveRecord::Migration
  def change
    create_table :baselines do |t|
      t.string :name
      t.integer :year_min
      t.integer :year_max

      t.timestamps
    end
  end
end
