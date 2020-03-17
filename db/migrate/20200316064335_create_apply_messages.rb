class CreateApplyMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :apply_messages do |t|
      t.text :body
      t.references :apply, foreign_key: true
      t.integer :user_id
      t.integer :company_id
      t.boolean :read, default: 0

      t.timestamps
    end
  end
end
