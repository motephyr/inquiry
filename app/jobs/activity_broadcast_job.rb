class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(activity)
    if activity.key == 'appraisal_message.create'
      ActionCable.server.broadcast "appraisal_message_/appraisals/#{activity.task_id}_channel",
        message: render_new_message(activity.trackable)
    end
    if activity.key == 'appraisal_message.create' || activity.key == 'appraisal.update'
      users = Appraisal.includes(cares: :user).find(activity.task_id).cares.map {|x| x.user}.uniq.select{|x| x.id != activity.owner_id}
      users.each do |user|
        if user.online?
          ActivityChannel.broadcast_to(
            user,
            message: render_activity(activity)
            )
        else
          #keep to mail
        end
        user_activity = PublicActivity::Activity.new(activity.attributes.select{ |key, _|  PublicActivity::Activity.attribute_names.include? key })
        user_activity.recipient_type = "User"
        user_activity.recipient_id = user.id
        user_activity.id = nil
        user_activity.save

      end
    end
  end

  private

  def render_new_message(appraisal_message)
    ApplicationController.renderer.render(partial: 'appraisal_messages/new_message', locals: {appraisal_message: appraisal_message})
  end

  def render_activity(activity)
    ApplicationController.renderer.render(partial: 'public_activity/activities/activity', locals: { activity: activity })
  end

end
