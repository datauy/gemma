class CreatePolls < ActiveRecord::Migration[8.0]
  def change
    create_table :polls do |t|
      t.string :title
      t.text :description
      t.references :area, null: false, foreign_key: true
      t.references :provision, null: false, foreign_key: true
      t.text :last_disclaimer

      t.timestamps
    end
  end
end
