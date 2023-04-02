class AddIsSortToAnimals < ActiveRecord::Migration[6.1]
  def change
    add_column :animals, :is_sort, :boolean, default: false, null: false
  end
end
