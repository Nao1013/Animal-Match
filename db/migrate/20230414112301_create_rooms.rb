class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :reader_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
