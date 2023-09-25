class AddForeignKeyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :posts, :users, column: :user_id
  end
end
