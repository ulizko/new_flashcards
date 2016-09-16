class ChangeLocaleDefaultFalseForUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :locale, :string, default: nil
  end
end
