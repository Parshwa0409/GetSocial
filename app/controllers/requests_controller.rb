class RequestsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_user
    skip_before_action :set_user, only: [:index]

    def index
        # TODO: TACKLE N+1 ISSUE
        @pending_requests = current_user.pending_requests
        @follow_requests = current_user.follow_requests
    end

    def follow
        current_user.send_follow_request_to(@user)
        # redirect_to profile_path(@user)
    end

    def unfollow
        current_user.unfollow(@user)
        # redirect_to root_path
    end
    
    def cancel
        current_user.remove_follow_request_for(@user)
        # redirect_to root_path
    end
    
    def accept
        current_user.accept_follow_request_of(@user)
        # redirect_to profile_path(@user)
    end
    
    def decline
        current_user.decline_follow_request_of(@user)
        # redirect_to root_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
