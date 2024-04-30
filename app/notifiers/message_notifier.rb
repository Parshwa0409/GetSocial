# To deliver this notification:
#
# MessageNotifier.with(record: @post, message: "New post").deliver(User.all)

class MessageNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.channel = "Noticed::MessageChannel"
    config.stream = ->{ recipient }
    config.message = ->{ params.merge( user_id: recipient.id) }
  end

  # Add required params
  required_param :message

  notification_methods do
    def message
      params[:message]
    end

    def sender
      params[:sender_email]
    end

    def file_attached?
      params[:attachment_attached]
    end
  end
end
