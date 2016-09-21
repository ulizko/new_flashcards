class AddStatusToAhoyEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_events, :status, :string
  end
end
