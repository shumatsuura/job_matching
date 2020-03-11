class CreateDesiredIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :desired_industries do |t|
      t.integer :user_id, null: false
      t.integer :industry_id, null: false

      t.timestamps
    end
  end
end
