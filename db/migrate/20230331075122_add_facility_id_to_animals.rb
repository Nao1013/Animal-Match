class AddFacilityIdToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :facility_id, :integer
  end
end
