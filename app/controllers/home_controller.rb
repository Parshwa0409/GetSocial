class HomeController < ApplicationController
  def index
    @feed = Post.where(user_id: active_user.following.pluck(:id)).includes([:user,:image_attachment]).order("created_at DESC ")
  end
end
