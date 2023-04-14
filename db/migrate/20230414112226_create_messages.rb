class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :reader_id
      t.integer :facility_id
      t.integer :room_id
      t.text :body, null: false
      t.boolean :is_deleted, default: "false", null: false

      t.timestamps
    end
  end
end
