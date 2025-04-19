class CreateEpisodes < ActiveRecord::Migration[8.0]
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :season
      t.integer :number
      t.string :image
      t.integer :tvmaze_id
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
