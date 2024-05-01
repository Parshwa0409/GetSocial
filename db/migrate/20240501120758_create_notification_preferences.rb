class CreateNotificationPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :notification_preferences do |t|
      t.references :preferred_user, null: false, foreign_key: { to_table: :users }
      t.references :preferred_notifier, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :notification_preferences, [:preferred_user_id, :preferred_notifier_id], unique: true
  end
end
