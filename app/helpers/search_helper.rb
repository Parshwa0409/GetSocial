module SearchHelper
    def render_content_if_no_users(users)
        if users.nil? || users.count == 0
            yield
        end
    end

    def render_users_if_any(users)
        unless users.nil? || users.count == 0
            yield
        end
    end
end
