class HomeController < ApplicationController
  def index
    @new_post = current_user.posts.build()
  end
end
