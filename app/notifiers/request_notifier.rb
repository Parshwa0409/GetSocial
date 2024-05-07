# To deliver this notification:
# RequestNotifier.with(record: @post, message: "New post").deliver(User.all)

class RequestNotifier < ApplicationNotifier
  # Add your delivery methods

  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  deliver_by :action_cable do |config|
    config.channel = "Noticed::RequestChannel"
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
