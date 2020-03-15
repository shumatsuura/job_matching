class CreatePostSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :post_skills do |t|
      t.integer :post_id
      t.integer :company_skill_id

      t.timestamps
    end
  end
end
