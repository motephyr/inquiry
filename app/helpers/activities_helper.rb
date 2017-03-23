module ActivitiesHelper
  def activity_created_at(activity)
    activity.created_at.strftime("%Y-%m-%d %H:%M")
  end
end
