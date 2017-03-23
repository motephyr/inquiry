class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient_type: "User", recipient_id: current_user.id)
    respond_to do |f|
      f.js
    end
  end
end
