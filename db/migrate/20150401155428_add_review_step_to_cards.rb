class AddReviewStepToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :review_step, :integer
  end
end
