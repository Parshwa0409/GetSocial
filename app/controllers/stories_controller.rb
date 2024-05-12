class StoriesController < ApplicationController
    before_action :set_story, only: [:show]
    
    def index
        @stories = Story.where(user_id: active_user.following.pluck(:id))
    end
    
    def create
        @story = Story.create(story_params)

        if @story.save
            flash[:notice]="Story has been successfully uploaded :)"
            redirect_to story_path(@story)
        else
            flash[:alert]= @story.errors.full_messages.to_sentence
            redirect_to profile_path(active_user)
        end
    end

    def show
    end

    def my_stories
        @stories = active_user.stories.includes(:pic_attachment)
    end

    private

    def set_story
        @story = Story.find(params[:id])
    end

    def story_params
        params.require(:story).permit(:pic).merge(user: active_user)
    end
end
