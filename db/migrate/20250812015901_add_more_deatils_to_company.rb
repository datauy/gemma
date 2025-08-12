class AddMoreDeatilsToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :countries, :text
    add_column :companies, :women_participation, :integer
    add_column :companies, :women_leadership, :integer
    add_column :companies, :disability, :integer
    add_column :companies, :start_date, :date
    add_column :companies, :registered, :boolean
    add_column :companies, :abilitation, :integer
    add_column :companies, :worker_insurance, :boolean
    add_column :companies, :building_abilitation, :integer
  end
end
