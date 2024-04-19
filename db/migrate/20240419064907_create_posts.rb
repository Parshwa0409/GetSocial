class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :image
      t.string :total_likes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
