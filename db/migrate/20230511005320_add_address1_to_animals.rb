class AddAddress1ToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :address1, :string
  end
end
