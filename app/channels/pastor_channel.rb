class PastorChannel < ApplicationCable::Channel
  def subscribed
     stream_from "pastor_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
