class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :pic
      t.integer :views, default: 0
      t.datetime :end_at, default: DateTime.now + 1

      t.timestamps
    end
  end
end
