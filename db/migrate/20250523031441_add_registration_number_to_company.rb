class AddRegistrationNumberToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :registration_number, :string
  end
end
