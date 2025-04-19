class CreateShows < ActiveRecord::Migration[8.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.text :summary
      t.string :image
      t.integer :tvmaze_id

      t.timestamps
    end
  end
end
