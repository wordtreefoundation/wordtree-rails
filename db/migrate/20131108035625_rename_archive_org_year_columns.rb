class RenameArchiveOrgYearColumns < ActiveRecord::Migration
  def change
    rename_column :archive_org_transfers, :min_year, :start_year
    rename_column :archive_org_transfers, :max_year, :end_year
  end
end
