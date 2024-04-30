class MessagesController < ApplicationController
    before_action :set_message, only: [:show]
    
    def index
        @msg_notifications = current_user.notifications.newest_first.where(type: "MessageNotifier::Notification")
    end


    def create
        message = Message.create(message_params)
        
        if message.save
            display_msg = "<u><strong>#{message.sender.email}</strong></u> says, '#{message.msg}'"
            attachment_attached = message.attachment.attached? 
            unless message.recipient == current_user
                notification = MessageNotifier.with(record: message, message: display_msg, attachment_attached: attachment_attached, sender_email: message.sender.email, recipient_id: message.recipient_id).deliver(message.recipient)
                ActionCable.server.broadcast("msg_channel",notification)
            end
            flash[:notice] = "Message Sent !!!"
        else
            flash[:alert] = message.errors.full_messages.to_sentence
        end

        redirect_to request.referer
    end

    def show
    end

    private

    def set_message
        @message = Message.find(params[:id])
    end

    def message_params
        params.require(:message).permit(:msg, :attachment, :recipient_id, :sender_id)
    end
end
