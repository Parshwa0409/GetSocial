class ProfileController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render :edit
    end
  end


  # TODO: DELETE USER PROFILE
  def destroy
    # Add logic for deleting profile
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio, :profile_picture, :cover_photo)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
