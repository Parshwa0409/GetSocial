module Profiles
    class Search
        def initialize(params)
            @params = params
            @users = []
        end

        def execute
            if @params[:name].present? && @params[:email].present?
                @users = User.where("name LIKE ? OR email LIKE ?", "%#{@params[:name]}%", "%#{@params[:email]}%").includes(:profile_picture_attachment)
            elsif @params[:name].present?
                @users = User.where("name LIKE ?", "%#{@params[:name]}%").includes(:profile_picture_attachment)
            elsif @params[:email].present?
                @users = User.where("email LIKE ?", "%#{@params[:email]}%").includes(:profile_picture_attachment)
            end
        end
    end
end
