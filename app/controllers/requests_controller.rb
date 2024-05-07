class RequestsController < ApplicationController
    # skip_before_action :verify_authenticity_token
    include RequestsHelper
    before_action :set_user
    skip_before_action :set_user, only: [:follow_requests, :pending_requests, :blocked_users]

    def follow_requests
        @follow_requests = active_user.follow_requests
    end

    def pending_requests
        @pending_requests = active_user.pending_requests
    end

    def follow
        active_user.send_follow_request_to(@user)
        Notifier::Request.notify( "New follow request from: ", active_user.email, @user)
    end

    def unfollow
        active_user.unfollow(@user)
    end
    
    def cancel
        active_user.remove_follow_request_for(@user)
    end
    
    def accept
        active_user.accept_follow_request_of(@user)    
    end
    
    def decline
        active_user.decline_follow_request_of(@user)
    end

    def block
        active_user.block(@user)
        remove_connections()
        redirect_to root_path
    end

    def unblock
        active_user.unblock(@user)
        redirect_to profile_path(@user)
    end

    def blocked_users
        @blocked_users = active_user.blocks
    end

    def remove_connections
        remove_connections_if_any(@user)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end
end
