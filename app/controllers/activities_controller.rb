class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner, :trackable)
    .where(recipient_type: "User", recipient_id: current_user.id)
    .order("created_at desc")
    .limit(10)

    respond_to do |f|
      f.js
    end
  end
end
