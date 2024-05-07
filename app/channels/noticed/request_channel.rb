class Noticed::RequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "request_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
