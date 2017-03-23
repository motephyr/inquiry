class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner, trackable: :appraisal).order("created_at desc").where(recipient_type: "User", recipient_id: current_user.id).limit(10)
    respond_to do |f|
      f.js
    end
  end
end
