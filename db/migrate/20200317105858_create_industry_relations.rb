class CreateIndustryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :industry_relations do |t|
      t.integer :company_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
