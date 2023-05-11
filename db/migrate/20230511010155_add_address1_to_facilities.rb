class AddAddress1ToFacilities < ActiveRecord::Migration[6.1]
  def change
    add_column :facilities, :address1, :string
  end
end
