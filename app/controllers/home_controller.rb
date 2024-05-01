class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @feed = Post.where(user_id: current_user.following.pluck(:id)).includes(:user).order("created_at DESC ")
  end
end
