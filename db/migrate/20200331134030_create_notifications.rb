class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :target_model
      t.integer :target_model_id
      t.boolean :read, default: 0
      t.string :action_model
      t.integer :action_model_id
      
      t.timestamps
    end
  end
end
