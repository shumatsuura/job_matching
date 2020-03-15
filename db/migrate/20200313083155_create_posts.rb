class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.integer :salary, null: false
      t.string :number_of_recruits, null: false
      t.string :position, null: false
      t.text :description, null: false
      t.string :location, null: false
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
