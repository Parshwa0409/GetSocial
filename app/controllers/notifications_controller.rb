class NotificationsController < ApplicationController
    def mark_all_pan_as_read
        active_user.notifications.where(type: "PostActivityNotifier::Notification").unread.mark_as_read
    end

    def mark_all_dm_as_read
        active_user.notifications.where(type: "MessageNotifier::Notification").unread.mark_as_read
    end
end
