module Profiles
    class Search
        def initialize(params, user_class = User)
            @users = []

            @params = params
            @user_class = user_class
        end

        def execute
            if @params[:name].present? && @params[:email].present?
                @users = @user_class.where("name LIKE ? OR email LIKE ?", "%#{@params[:name]}%", "%#{@params[:email]}%").includes(:profile_picture_attachment)
            elsif @params[:name].present?
                @users = @user_class.where("name LIKE ?", "%#{@params[:name]}%").includes(:profile_picture_attachment)
            elsif @params[:email].present?
                @users = @user_class.where("email LIKE ?", "%#{@params[:email]}%").includes(:profile_picture_attachment)
            end

            return @users
        end
    end
end
