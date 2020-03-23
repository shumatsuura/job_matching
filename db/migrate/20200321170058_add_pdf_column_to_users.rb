class AddPdfColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cv, :text
  end
end
