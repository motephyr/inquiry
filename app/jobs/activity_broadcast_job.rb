class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(activity)
    user = User.find(activity.recipient_id)
    if user.online?
      ActivityChannel.broadcast_to(
        user,
        message: render_activity(activity)
      )
    end
  end

  private

  def render_activity(activity)
    ApplicationController.renderer.render(partial: 'public_activity/activities/activity', locals: { activity: activity })
  end
end
