class AddOtypeToOption < ActiveRecord::Migration[8.0]
  def change
    add_column :options, :otype, :integer
  end
end
