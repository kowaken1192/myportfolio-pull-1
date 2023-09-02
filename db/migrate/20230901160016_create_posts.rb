class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :country
      t.text :address
      t.text :detail
      t.string :postimage

      t.timestamps
    end
  end
end
