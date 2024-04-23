class HomeController < ApplicationController
  def index
    @feed = Post.where(user_id: current_user.following.pluck(:id)).includes(:user)
  end
end
