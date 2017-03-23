class ActivityChannel < ApplicationCable::Channel
  def subscribed
    if current_user
     stream_for current_user
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
