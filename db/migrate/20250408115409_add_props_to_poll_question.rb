class AddPropsToPollQuestion < ActiveRecord::Migration[8.0]
  def change
    add_reference :poll_questions, :semaphore, null: false, foreign_key: true, default: 1
    add_column :poll_questions, :condition_question, :integer
    add_column :poll_questions, :condition_operator, :integer
    add_column :poll_questions, :condition_value, :integer
    add_column :poll_questions, :section_yellow, :boolean
    add_column :poll_questions, :section_red, :boolean
    add_column :poll_questions, :question_weight, :integer
  end
end
