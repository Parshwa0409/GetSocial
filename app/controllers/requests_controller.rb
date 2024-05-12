class RequestsController < ApplicationController
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
        active_user.send_follow_request_to(@target)
        Notifier::Request.notify( "New follow request from: ", active_user.email, @target)
    end

    def unfollow
        active_user.unfollow(@target)
    end

    def cancel
        active_user.remove_follow_request_for(@target)
    end

    def accept
        active_user.accept_follow_request_of(@target)    
    end

    def decline
        active_user.decline_follow_request_of(@target)
    end

    def block
        active_user.block(@target)
        remove_connections_if_any(@target)
        redirect_to root_path
    end

    def unblock
        active_user.unblock(@target)
        redirect_to profile_path(@target)
    end

    def blocked_users
        @blocked_users = active_user.blocks
    end

    private
    def set_user
        @target = User.find(params[:id])
    end
end
