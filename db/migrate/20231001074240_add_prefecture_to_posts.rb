class AddPrefectureToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :prefecture, :string
  end
end
