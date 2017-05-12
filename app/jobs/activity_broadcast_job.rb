class ActivityBroadcastJob < ApplicationJob
  queue_as :default

  def perform(activity)
    if activity.task_id > 0
      if activity.key == 'appraisal_message.create'
        ActionCable.server.broadcast "appraisal_message_/appraisals/#{activity.task_id}_channel",
          message: render_new_message(activity.trackable)
      end

      if activity.key == 'appraisal_message.create' || activity.key == 'appraisal.update'
        appraisal = Appraisal.includes(cares: :user).find(activity.task_id)
        users = appraisal.cares.map {|x| x.user}.push(appraisal.user).uniq.select{|x| x.id != activity.owner_id}
        send_online_user_message_and_set_recipient(activity, users)
      elsif activity.key == 'work_message.create'
        work = Work.includes(work_messages: :user).find(activity.task_id)
        users = work.work_messages.map {|x| x.user}.push(work.user).uniq.select{|x| x.id != activity.owner_id}
        send_online_user_message_and_set_recipient(activity, users)
        
      elsif activity.key == 'care.create'
        care = Care.find_by_id(activity.task_id)
        if care.present? && care.careable_type == 'Work'
          user = Work.includes(:user).find(care.careable_id).user
          if user.id != care.user_id
            send_online_user_message_and_set_recipient(activity, [user])
          end
        end
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

  def send_online_user_message_and_set_recipient(activity, users)
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
