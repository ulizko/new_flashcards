class AddCurrentBlockToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_block, :integer, null: true
  end
end
