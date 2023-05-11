class AddAddress2ToFacilities < ActiveRecord::Migration[6.1]
  def change
    add_column :facilities, :address2, :string
  end
end
