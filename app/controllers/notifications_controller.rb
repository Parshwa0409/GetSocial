class NotificationsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def mark_all_pan_as_read
        current_user.notifications.where(type: "PostActivityNotifier::Notification").unread.mark_as_read
    end

    def mark_all_dm_as_read
        current_user.notifications.where(type: "MessageNotifier::Notification").unread.mark_as_read
    end
end
