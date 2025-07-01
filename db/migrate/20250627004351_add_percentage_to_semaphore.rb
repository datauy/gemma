class AddPercentageToSemaphore < ActiveRecord::Migration[8.0]
  def change
    add_column :semaphores, :percentage, :integer
  end
end
