module MessagesHelper
    def render_message_if_unread(notification)
        if notification.unread? 
            yield
        end
    end

    def render_view_attachment_btn(notification)
        if notification.file_attached?
            yield
        end
    end
end

