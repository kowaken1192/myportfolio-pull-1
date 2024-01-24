class AddNotNullConstraintToReviewsScore < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :score, :integer, null: false
  end
end
