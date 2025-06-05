class AddTotalToEvaluation < ActiveRecord::Migration[8.0]
  def change
    add_column :evaluations, :total, :integer
  end
end
