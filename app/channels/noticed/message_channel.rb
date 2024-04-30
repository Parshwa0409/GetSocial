class Noticed::MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "msg_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
