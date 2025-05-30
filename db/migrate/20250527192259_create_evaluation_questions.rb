class CreateEvaluationQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :evaluation_questions do |t|
      t.references :question, null: false, foreign_key: true
      t.references :evaluation, null: false, foreign_key: true
      t.text :qvalue

      t.timestamps
    end
  end
end
