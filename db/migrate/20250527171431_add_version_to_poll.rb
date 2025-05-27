class AddVersionToPoll < ActiveRecord::Migration[8.0]
  def change
    add_column :polls, :version, :integer, default: 1, null: false
    add_column :polls, :enabled, :boolean, default: false, null: false
  end
end
