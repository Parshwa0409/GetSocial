class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :caption
      t.string :image
      t.integer :total_likes, default: 0
      t.integer :total_comments, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
