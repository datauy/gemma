class CreateCompanyMainCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :company_main_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :main_company_id, null: false

      t.timestamps
    end
  end
end
