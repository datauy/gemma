class AddSemaphoreToQuestion < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :semaphore, null: false, foreign_key: true
  end
end
