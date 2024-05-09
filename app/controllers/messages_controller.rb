class MessagesController < ApplicationController
    before_action :set_message, only: [:show]

    def index
        @messages = active_user.notifications.newest_first.where(type: "MessageNotifier::Notification")
    end


    def create
        # debugger
        message = Message.create(message_params)
        
        if message.save
            Notifier::Message.notify(
                message,
                "<u><strong>#{message.sender.email}</strong></u> says, '#{message.msg}'", 
                message.attachment.attached?
            )
            flash[:notice] = "Message Sent !!!"
            
        else
            flash[:alert] = message.errors.full_messages.to_sentence
        end

        # TODO: REDO THE FORM ONCE & TRY
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
