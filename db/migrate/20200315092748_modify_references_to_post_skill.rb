class ModifyReferencesToPostSkill < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :company_skills, :users
    remove_index :company_skills, :user_id
    remove_reference :company_skills, :user
    add_reference :company_skills, :company, foreign_key: true
  end
end
