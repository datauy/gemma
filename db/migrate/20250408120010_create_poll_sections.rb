class CreatePollSections < ActiveRecord::Migration[8.0]
  def change
    create_table :poll_sections do |t|
      t.references :section, null: false, foreign_key: true
      t.references :poll, null: false, foreign_key: true
      t.references :semaphore, null: false, foreign_key: true

      t.timestamps
    end
  end
end
