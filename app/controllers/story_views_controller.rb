class StoryViewsController < ApplicationController
    before_action :get_story

    def create
        view = StoryView.find_by(user: active_user, story: @story)

        unless view.present?
            new_view = StoryView.create(user: active_user, story: @story)
            @story.update(:views => (@story.views + 1)) if new_view.save()
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
