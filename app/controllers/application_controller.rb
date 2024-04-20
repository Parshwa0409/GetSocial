class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    before_action :build_new_post


    def build_new_post
        @new_post = current_user.posts.build()
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :profile_picture, :cover_photo])
    end
end
