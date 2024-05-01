class NotificationPreference < ApplicationRecord
  belongs_to :preferred_user, class_name: "User"
  belongs_to :preferred_notifier, class_name: "User"
end
