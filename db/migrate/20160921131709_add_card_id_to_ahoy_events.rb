class AddCardIdToAhoyEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :ahoy_events, :card_id, :integer
  end
end
