class ChangeTotalFromIntegerToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :evaluations, :total, :decimal, precision: 8, scale: 2
  end
end
