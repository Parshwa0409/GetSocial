class SearchController < ApplicationController

  def search
    @users = []
  end

  def query
    query = search_params
    @users = []

    if query[:name].present? && query[:email].present?
      @users = User.where("name = ? OR email = ?", query[:name], query[:email])
    elsif query[:name].present?
      @users = User.where(name: query[:name])
    elsif query[:email].present?
      @users = User.where(email: query[:email])
    else
      @users = []
    end

    render partial: "users", locals: { users:@users }
  end

  private

  def search_params
    params.require(:search).permit(:name, :email)
  end
end
