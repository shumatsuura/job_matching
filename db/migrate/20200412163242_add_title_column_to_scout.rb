class AddTitleColumnToScout < ActiveRecord::Migration[5.2]
  def change
    add_column :scouts, :title, :string
  end
end
