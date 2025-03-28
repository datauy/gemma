class CreatePollQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :poll_questions do |t|
      t.references :poll, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
