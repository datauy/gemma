class AddNameToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :name, :string
  end
end
