class AddMessageColumnToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :message, :string
  end
end
