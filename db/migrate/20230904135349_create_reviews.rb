class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :review_images
      t.string :title
      t.string :content
      t.integer :score

      t.timestamps
    end
  end
end
