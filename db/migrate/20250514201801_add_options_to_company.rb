class AddOptionsToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :is_confirmed, :boolean
    add_column :companies, :is_main_company, :boolean
  end
end
