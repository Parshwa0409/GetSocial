class ProfileController < ApplicationController
  include NotificationPreferencesHelper
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts = Profiles::Details.call(@user)
  end

  def edit
  end

  def update
    if Profiles::Updator.call(@user, user_params)
      redirect_to profile_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio, :profile_picture, :cover_photo)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
