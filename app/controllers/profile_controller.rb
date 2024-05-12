class ProfileController < ApplicationController
  include NotificationPreferencesHelper
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = @user.posts.includes(:image_attachment).order("created_at DESC ")
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
    .permit(
      :name,
      :email, 
      :bio, 
      :profile_picture, 
      :cover_photo
    )
  end

  def set_user
    @user = User.find(params[:id])
  end

end
