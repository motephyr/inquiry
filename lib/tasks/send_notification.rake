
namespace :send_notification do

  desc "send_unlogin_notification"
  task :unlogin => :environment do
    users = User.where('current_sign_in_at < ?', 1.days.ago) #每一天寄給超過一天沒登入的人未讀的訊息。
    users.each do |user|
      activities = PublicActivity::Activity.includes(:owner, :trackable).where(recipient_type: "User", recipient_id: user.id).where("created_at > ?", user.noticed_at).order("created_at desc")
      if activities.present?
        puts "send_unlogin_notification: " + user.email
        content = ApplicationController.renderer.new.render(activities)
        AcitvityMailer.unlogin_notification(user, content).deliver_now!
        user.touch(:noticed_at)
      end
    end

    # users = User.where('id in (?)', [1,3]) #每三天寄給超過三天沒登入的人前三天的10則訊息。
    # users.each do |user|
    #   activities = PublicActivity::Activity.includes(:owner, :trackable).where(recipient_type: "User", recipient_id: user.id).order("created_at desc").limit(10)
    #   if activities.present?
    #     content = ApplicationController.renderer.new.render(activities)
    #     AcitvityMailer.unlogin_notification(user, content).deliver_later!
    #   end
    # end
  end

  desc "send_works_notification"
  task :works => :environment do
    send_to_users = User.where('current_sign_in_at < ?', 2.days.ago) # 超過兩天沒登入的人。
    send_to_users.each do |user|
      # 取得 除了自己之外的人 最近一週的新作品 並隨機取 10 個
      workslist = Work.where('user_id != ? and created_at >= ?', user.id, 7.days.ago).order("RANDOM()").limit(10)
      if workslist.present?
        puts "send_works_notification: " + user.email
        # ...
        # AcitvityMailer.works_notification(user, content).deliver_now!
        AcitvityMailer.works_notification(user, workslist).deliver_now!
      end
    end
  end

end
