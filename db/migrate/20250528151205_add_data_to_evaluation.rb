class AddDataToEvaluation < ActiveRecord::Migration[8.0]
  def change
    add_column :evaluations, :is_submitted, :boolean
    add_column :evaluations, :submitted_date, :date
  end
end
