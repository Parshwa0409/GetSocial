class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
  end

  def edit
  end

  def update
    @user.update(user_params)

    if @user.save
      redirect_to profile_path(@user)
    else
      render :edit
    end
  end

  # TODO: CREATE OPTION TO DELETE PROFILE

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio, :profile_picture, :cover_photo)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
