class RenameReviewImagesToImageAgain < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :review_images, :image
  end
end
