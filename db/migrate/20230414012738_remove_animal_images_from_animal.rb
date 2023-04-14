class RemoveAnimalImagesFromAnimal < ActiveRecord::Migration[6.1]
  def change
    remove_column :animals, :Images, :string
  end
end
