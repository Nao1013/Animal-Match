class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :animal_id
      t.integer :facility_id
      t.integer :reader_id
      t.text :comment
      t.timestamps
    end
  end
end
