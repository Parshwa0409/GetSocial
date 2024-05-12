class StoryViewsController < ApplicationController
    before_action :get_story

    def create
        unless StoryView.exists?(user: active_user, story: @story)
            new_view = StoryView.create(user: active_user, story: @story)
            @story.increment!(:views) if new_view.persisted?
        end
    end


    private
    def get_story
        @story = Story.find(params[:story_id])
    end

    def get_params
        params.permit(:story_id)
    end
end
