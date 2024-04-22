class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # TODO: :authenticate_user!, to induvidual controllers
    before_action :authenticate_user!
    before_action :build_new_post


    def build_new_post
        @new_post = current_user.posts.build() if user_signed_in?
    end

    # TODO: REMOVE UNWANTED DEVISE LINKS & PATHS
    # TODO: CHANGE BTN-PRIMARY -> BTN-OUTLINE-DARK

    # TODO: MEMOIZE THE current_user() inherited fro devise
    # def current_user
    #     @current_user ||= current_user
    # end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :profile_picture, :cover_photo])
    end
end
