class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :init_users

  def search
  end

  def query
    query = search_params

    if query[:name].present? && query[:email].present?
      @users = User.where("name LIKE ? OR email LIKE ?", "%#{query[:name]}%", "%#{query[:email]}%")
    elsif query[:name].present?
      @users = User.where("name LIKE ?", "%#{query[:name]}%")
    elsif query[:email].present?
      @users = User.where("email LIKE ?", "%#{query[:email]}%")
    else
      @users = []
    end

    @users = @users.reject {|user| user.blocked_by?(current_user) || current_user.blocked_by?(user) }

    render partial: "users", locals: { users:@users }
  end

  private

  def search_params
    params.require(:search).permit(:name, :email)
  end

  def init_users
    @users= []
  end
end
