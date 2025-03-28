class AddOvalueToOption < ActiveRecord::Migration[8.0]
  def change
    add_column :options, :ovalue, :string
  end
end
