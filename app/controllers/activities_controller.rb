class ActivitiesController < ApplicationController
  def index
    # TODO: TACKLE N+1 ISSUE
    @pending_requests_count = current_user.pending_requests.count
    @follow_requests_count = current_user.follow_requests.count
  end
end
