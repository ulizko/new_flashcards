class AddGroupToAhoyEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_events, :group, :string
  end
end
