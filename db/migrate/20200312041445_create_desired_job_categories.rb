class CreateDesiredJobCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :desired_job_categories do |t|
      t.integer :user_id, null: false
      t.integer :job_category_id, null: false

      t.timestamps
    end
  end
end
