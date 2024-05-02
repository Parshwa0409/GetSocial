class ActivitiesController < ApplicationController
  def index
    @pending_requests_count = active_user.pending_requests.count
    @follow_requests_count = active_user.follow_requests.count

    @post_activity_notifications = active_user.notifications.newest_first.where(type: "PostActivityNotifier::Notification")
  end
end
