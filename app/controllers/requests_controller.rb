class RequestsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_user
    skip_before_action :set_user, only: [:follow_requests, :pending_requests]

    def follow_requests
        @follow_requests = current_user.follow_requests
    end

    def pending_requests
        @pending_requests = current_user.pending_requests
    end

    def follow
        current_user.send_follow_request_to(@user)
    end

    def unfollow
        current_user.unfollow(@user)
    end
    
    def cancel
        current_user.remove_follow_request_for(@user)
    end
    
    def accept
        current_user.accept_follow_request_of(@user)
    end
    
    def decline
        current_user.decline_follow_request_of(@user)
    end

    # TODO: BLOCK & UNBLOCK USERS

    private

    def set_user
        @user = User.find(params[:id])
    end
end
