class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :msg
      t.string :attachment

      t.timestamps
    end
  end
end
