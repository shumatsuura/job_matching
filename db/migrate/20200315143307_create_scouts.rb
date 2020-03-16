class CreateScouts < ActiveRecord::Migration[5.2]
  def change
    create_table :scouts do |t|
      t.integer :company_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
