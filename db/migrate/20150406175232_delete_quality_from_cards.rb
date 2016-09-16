class DeleteQualityFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :quality
  end
end
