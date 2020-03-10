class CreateEducations < ActiveRecord::Migration[5.2]
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :major
      t.datetime :period_start
      t.datetime :period_end
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
