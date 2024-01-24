class AddNullFalseToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :name, :string, null: false
    change_column :posts, :address, :text, null: false
    change_column :posts, :country, :string, null: false
  end
end
