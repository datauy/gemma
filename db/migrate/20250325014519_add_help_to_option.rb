class AddHelpToOption < ActiveRecord::Migration[8.0]
  def change
    add_column :options, :prefix, :text
    add_column :options, :sufix, :text
  end
end
