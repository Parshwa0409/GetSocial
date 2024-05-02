module StoriesHelper
    def render_if_not_viewed(story)
        unless StoryView.find_by(user: active_user, story: story).present?
            yield
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
