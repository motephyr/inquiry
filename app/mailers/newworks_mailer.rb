class NewworksMailer < ApplicationMailer
  include Roadie::Rails::Mailer
  helper :application # 這樣會載入 app/helpers/application_helper.rb

  def newworks_notification(user, works)
    @user = user
    @works = works
    roadie_mail(to: @user.email, subject: 'Conkwe 動態：有些新的作品在 Conkwe 發表了，快來看看吧')
  end
end
