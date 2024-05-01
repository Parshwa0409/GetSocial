class RequestsController < ApplicationController
    # skip_before_action :verify_authenticity_token
    before_action :set_user
    skip_before_action :set_user, only: [:follow_requests, :pending_requests, :blocked_users]

    # TODO: How to Redirect !!!!!!

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
        redirect_to root_path
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

    def block
        current_user.block(@user)
        remove_connections()
        redirect_to root_path
    end

    def unblock
        current_user.unblock(@user)
    end

    def blocked_users
        @blocked_users = current_user.blocks
    end

    def remove_connections
        if current_user.mutual_following_with?(@user)
            current_user.unfollow(@user)
            @user.unfollow(current_user)
        elsif current_user.following?(@user)
            current_user.unfollow(@user)
        elsif @user.following?(current_user)
            @user.unfollow(current_user)
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
