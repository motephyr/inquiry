
namespace :send_notification do

  desc "send_unlogin_notification"
  task :unlogin => :environment do
    users = User.where('current_sign_in_at < ?', 3.days.ago) #每三天寄給超過三天沒登入的人前三天的10則訊息。
    users.each do |user|
      activities = PublicActivity::Activity.includes(:owner, trackable: :appraisal).where(recipient_type: "User", recipient_id: user.id).where("created_at >= ?", 3.days.ago).order("created_at desc").limit(10)
      if activities.present?
        content = ApplicationController.renderer.render(activities)
        AcitvityMailer.unlogin_notification(user, content)
      end
    end
  end

end
