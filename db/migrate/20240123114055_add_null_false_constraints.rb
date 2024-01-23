class AddNullFalseConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :user_id, :integer, null: false
    change_column :reviews, :score, :integer, null: false
  end
end
