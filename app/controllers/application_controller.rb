class ApplicationController < ActionController::Base
    include ApplicationHelper
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :profile_picture, :cover_photo])
    end
end
