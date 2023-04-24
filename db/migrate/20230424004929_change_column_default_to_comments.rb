class ChangeColumnDefaultToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :comments, :is_deleted, from: nil, to: "false"
  end
end
