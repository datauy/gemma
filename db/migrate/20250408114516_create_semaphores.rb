class CreateSemaphores < ActiveRecord::Migration[8.0]
  def change
    create_table :semaphores do |t|
      t.string :formula
      t.text :green_text
      t.integer :green_value
      t.text :yellow_text
      t.text :red_text
      t.integer :red_value

      t.timestamps
    end
  end
end
