class ActivitiesController < ApplicationController
  def index
    current_user.touch(:noticed_at)

    @activities = PublicActivity::Activity.includes(:owner, :trackable)
    .where(recipient_type: "User", recipient_id: current_user.id)
    .order("created_at desc")
    .limit(10)

    respond_to do |f|
      f.js
    end
  end

  def show
        content = ApplicationController.renderer.new.render(Work.where('works.id = 4 or works.id = 3'))
        AcitvityMailer.works_notification(User.find(1), content).deliver_now!
  end

    
end
