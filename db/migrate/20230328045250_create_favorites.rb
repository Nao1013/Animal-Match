class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :reader_id
      t.integer :animal_id

      t.timestamps
    end
  end
end
