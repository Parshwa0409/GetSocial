class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :build_new_post
    
    # TODO: :authenticate_user!, to induvidual controllers
    before_action :authenticate_user!

    def build_new_post
        @new_post = current_user.posts.build() if user_signed_in?
    end

    # TODO: REMOVE UNWANTED DEVISE LINKS & PATHS
    # TODO: REMOVE LOGOUT BTN FROM PROFILE ADD SHARE PROFILE

    # TODO: MEMOIZE THE current_user() inherited from devise
    # def current_user
    #     @current_user ||= current_user

    #     return @current_user
    # end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :profile_picture, :cover_photo])
    end
end
