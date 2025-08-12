class AddMoreToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :worker_registration, :integer
  end
end
