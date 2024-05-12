module StoriesHelper
    def view_story_link(story)
        if StoryView.find_by(user: active_user, story: story).nil?
            link_to "View Story", story, class: "view-story-btn link-dark", data: {"story-id": story.id}
        else
            link_to "View Again", story, class: "view-story-btn link-dark", data: {"story-id": story.id}
        end
    end


    def render_my_stories_if_present(stories)
        if stories.length > 0 
            yield
        end
    end

    def render_content_if_no_stories(stories)
        unless stories.length > 0 
            yield
        end
    end
end
