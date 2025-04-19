class CreateActors < ActiveRecord::Migration[8.0]
  def change
    create_table :actors do |t|
      t.string :name
      t.string :image
      t.string :character
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
