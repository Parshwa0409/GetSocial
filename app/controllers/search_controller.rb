class SearchController < ApplicationController
  before_action :init_users, only: [:search]

  def search
  end

  def query
    @users = Profiles::Search.new(search_params).execute
    @users  = @users.reject {|user| user.blocked_by?(active_user) || active_user.blocked_by?(user) }
    render partial: "users", locals: { users: @users }
  end

  private

  def search_params
    params.require(:search).permit(:name, :email)
  end

  def init_users
    @users = []
  end
end
