class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.text :introduct, null: false
      t.boolean :is_decided, null: false, default: "false"

      t.timestamps
    end
  end
end
