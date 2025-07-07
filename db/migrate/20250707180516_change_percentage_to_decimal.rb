class ChangePercentageToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :semaphores, :percentage, :decimal, precision: 8, scale: 2
  end
end
