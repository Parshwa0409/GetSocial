class NotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def mark_pan_as_read
        notification = current_user.notifications.find(params[:id])
        notification.mark_as_read
    end

    def mark_all_pan_as_read
        current_user.notifications.unread.mark_as_read
    end
end
