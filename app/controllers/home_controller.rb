class HomeController < ApplicationController
  def index
    @feed = Post.where(user_id: current_user.following.pluck(:id)).includes(:user).order("created_at DESC ")
  end
end
