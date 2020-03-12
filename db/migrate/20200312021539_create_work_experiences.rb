class CreateWorkExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :work_experiences do |t|
      t.string :company
      t.string :position
      t.datetime :period_start
      t.datetime :period_end
      t.boolean :currently_employed
      t.text :description
      t.integer :salary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
