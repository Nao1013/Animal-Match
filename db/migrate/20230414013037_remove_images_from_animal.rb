class RemoveImagesFromAnimal < ActiveRecord::Migration[6.1]
  def change
    remove_column :animals, :images, :string
  end
end
