class CreateAnimalGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_genres do |t|
      t.integer :animal_id, null: false
      t.integer :genre_id, null: false
      t.timestamps
    end
  end
end
