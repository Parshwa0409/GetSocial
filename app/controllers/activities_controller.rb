class ActivitiesController < ApplicationController
  def index
    @pending_requests_count = current_user.pending_requests.count
    @follow_requests_count = current_user.follow_requests.count
  end

  # TODO: Likes & Comments Notification
end
