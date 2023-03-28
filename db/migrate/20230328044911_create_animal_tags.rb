class CreateAnimalTags < ActiveRecord::Migration[6.1]
  def change
    create_table :animal_tags do |t|
      t.integer :animal_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
