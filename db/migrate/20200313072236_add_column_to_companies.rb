class AddColumnToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :name, :string
    add_column :companies, :phone_number, :string
    add_column :companies, :location, :string
    add_column :companies, :address, :string
    add_column :companies, :number_of_employees, :integer
    add_column :companies, :date_of_incorporation, :datetime
    add_column :companies, :paid_up_capital, :integer
    add_column :companies, :logo, :text
    add_column :companies, :header_image, :text
    add_column :companies, :image, :text
    add_column :companies, :email_for_inquiry, :string
    add_column :companies, :member_status, :integer
  end
end
