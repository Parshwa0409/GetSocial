module ApplicationHelper
    def active_user
        @current_user ||= user_signed_in? ? current_user : nil
    end

    def pan_count
        @pan_count = active_user.notifications.where(type: ["PostActivityNotifier::Notification"]).unread.count
    end

    def pan_badge_visibility
        return pan_count > 0 ? "visible" : "invisible"
    end

    def msg_count
        @msg_count = active_user.notifications.where(type: "MessageNotifier::Notification").unread.count
    end

    def msg_badge_visibility
        return msg_count > 0 ? "visible" : "invisible"
    end

    def build_new_post
        @new_post = current_user.posts.new() unless active_user.nil?
    end

    def render_profile_pic_if_attached(user)
        if user.profile_picture.attached?
            yield
        end
    end

    def render_default_pic_if_profile_pic_not_attached(user)
        unless user.profile_picture.attached?
            yield
        end
    end
end
