class AddAnimalImagesToAnimal < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :images, :string
  end
end
