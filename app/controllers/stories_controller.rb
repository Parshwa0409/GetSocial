class StoriesController < ApplicationController
    before_action :set_story, only: [:show]
    
    def index
        @stories = []
        active_user.following.each do |user|
            @stories += (user.stories.where("? < end_at", DateTime.now))
        end
    end
    
    def create
        story = Story.create(story_params)

        if story.save
            flash[:notice]="Story Uploaded ;)"
            redirect_to story_path(story)
        else
            flash[:alert]= story.errors.full_messages.to_sentence
            redirect_to request.referer
        end
    end

    def show
    end

    def my_stories
        @stories = active_user.stories
    end
    private

    def set_story
        @story = Story.find(params[:id])
    end

    def story_params
        params.require(:story).permit(:pic).merge(user: active_user)
    end
end
