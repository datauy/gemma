class CreateDestinationsRelations < ActiveRecord::Migration[8.0]
  def change
    create_table :destinations_relations do |t|
      t.references :destination, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
