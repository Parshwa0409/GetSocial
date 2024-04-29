class Noticed::PanChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pan_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
