class ChangeUserIdFieldFromCards < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :user_id, :integer, null: false
  end
end
