class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(activity)
    if activity.key == 'appraisal_message.create' || activity.key == 'appraisal.update'
      users = Appraisal.includes(cares: :user).find(activity.task_id).cares.map {|x| x.user}.uniq.select{|x| x.id != activity.owner_id}
      users.each do |user|
        if user.online?
          ActivityChannel.broadcast_to(
            user,
            message: render_activity(activity)
          )
        end
      end
    end
  end

  private

  def render_activity(activity)
    ApplicationController.renderer.render(partial: 'public_activity/activities/activity', locals: { activity: activity })
  end
end
