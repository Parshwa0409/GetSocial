module Notifier
    class Request
      def self.notify(message, sender_email, recipient)
        notification = RequestNotifier.with(message: message, sender_email: sender_email, recipient_id: recipient.id).deliver(recipient)

        ActionCable.server.broadcast("request_channel", notification)
      end
    end
  end
  

