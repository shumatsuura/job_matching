class CreateScoutMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :scout_messages do |t|
      t.string :title
      t.text :body
      t.references :scout, foreign_key: true
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
