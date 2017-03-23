class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from("appearances_channel")
    if current_user.present?
      redis.set("user_#{current_user.id}_online", "1")
      ActionCable.server.broadcast "appearances_channel",
                                   user_id: current_user.id,
                                   online: true
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    if current_user.present?
      redis.del("user_#{current_user.id}_online")
      ActionCable.server.broadcast "appearances_channel",
                                   user_id: current_user.id,
                                   online: false
    end
  end

  private

  def redis
    Redis.new
  end
end
