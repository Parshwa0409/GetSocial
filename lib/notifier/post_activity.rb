module Notifier
  class PostActivity

    def self.notify(message, post_create, record, sender_email, recipient)
      unless sender_email==recipient.email
        pan = PostActivityNotifier.with(record: record, message: message, sender_email: sender_email, recipient_id: recipient.id, post_create: post_create).deliver(recipient) 

        ActionCable.server.broadcast("pan_channel",pan)
      end
    end

    def self.notify_all(message, post_create, record, sender_email, recipients)
      pan = PostActivityNotifier.with(record: record, message: message, sender_email: sender_email, recipient_ids: recipients.pluck(:id) , post_create: post_create).deliver(recipients) 

      ActionCable.server.broadcast("pan_channel",pan)
    end

  end
end
