class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :reader_id, null: false
      t.integer :facility_id, null: false
      t.text :body, null: false
      t.boolean :is_deleted, null: false, default: "false"

      t.timestamps
    end
  end
end
