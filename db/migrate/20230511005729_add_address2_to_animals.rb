class AddAddress2ToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :address2, :string
  end
end
