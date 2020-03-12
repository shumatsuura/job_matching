class CreateQualifications < ActiveRecord::Migration[5.2]
  def change
    create_table :qualifications do |t|
      t.string :name
      t.datetime :date_of_acquisition
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
