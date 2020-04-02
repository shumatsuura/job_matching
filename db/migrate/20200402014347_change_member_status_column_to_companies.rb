class ChangeMemberStatusColumnToCompanies < ActiveRecord::Migration[5.2]
  def change
    change_column :companies, :member_status, :integer, default: 0
  end
end
