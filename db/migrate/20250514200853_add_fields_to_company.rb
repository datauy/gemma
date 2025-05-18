class AddFieldsToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :fake_name, :string
    add_column :companies, :state, :integer
    add_column :companies, :address, :string
    add_column :companies, :activity, :integer
    add_column :companies, :size, :integer
    add_column :companies, :man_workers, :integer
    add_column :companies, :woman_workers, :integer
    add_column :companies, :start_year, :integer
    add_column :companies, :contact_name, :string
    add_column :companies, :contact_position, :string
    add_column :companies, :contact_tel, :string
    add_column :companies, :contact_email, :string
  end
end
