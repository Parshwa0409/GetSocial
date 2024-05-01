class ActivitiesController < ApplicationController
  def index
    @pending_requests_count = current_user.pending_requests.count
    @follow_requests_count = current_user.follow_requests.count

    @post_activity_notifications = current_user.notifications.newest_first.where(type: "PostActivityNotifier::Notification")
  end
end
