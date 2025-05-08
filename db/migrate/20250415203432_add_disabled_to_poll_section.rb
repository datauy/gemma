class AddDisabledToPollSection < ActiveRecord::Migration[8.0]
  def change
    add_column :poll_sections, :disabled, :boolean
  end
end
