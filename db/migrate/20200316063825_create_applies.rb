class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
