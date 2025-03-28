class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.integer :qtype
      t.string :title
      t.text :description
      t.references :questions, :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
