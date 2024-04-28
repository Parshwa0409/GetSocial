# To deliver this notification:
#
# PostActivityNotifier.with(record: @post, message: "New post").deliver(User.all)

class PostActivityNotifier < ApplicationNotifier
  # Delivery Methods
  
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

  # Add required params
  required_param :message

  notification_methods do
    def message
      params[:message]
    end

    def sender
      params[:user_email]
    end
  end
end
