module Notifier
  class Message
    def self.notify(record, message, attachment_attached)
        notification = MessageNotifier.with(record: record, message: message, attachment_attached: attachment_attached, sender_email: record.sender.email, recipient_id: record.recipient_id).deliver(record.recipient)

        ActionCable.server.broadcast("msg_channel",notification)
    end
  end
end
