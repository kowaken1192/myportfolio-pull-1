class AddPostIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :post_id, :integer
  end
end
