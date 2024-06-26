# To deliver this notification: PostActivityNotifier.with(record: @post, message: "New post").deliver(User.all)

class PostActivityNotifier < ApplicationNotifier
  deliver_by :action_cable do |config|
    config.channel = "Noticed::PanChannel"
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
  end
end
