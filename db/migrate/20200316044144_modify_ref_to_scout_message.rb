class ModifyRefToScoutMessage < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :scout_messages, :users
    remove_foreign_key :scout_messages, :companies
    remove_index :scout_messages, :user_id
    remove_index :scout_messages, :company_id
    remove_reference :scout_messages, :user
    remove_reference :scout_messages, :company    
  end
end
