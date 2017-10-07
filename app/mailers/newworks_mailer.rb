class NewworksMailer < ApplicationMailer
  include Roadie::Rails::Mailer
  helper :application # 這樣會載入 app/helpers/application_helper.rb

  def newworks_notification(user, works)
    @user = user
    @works = works
    roadie_mail(to: @user.email, subject: '[動態] ' + user.nickname + '，有其他人新的工作成果在 Conkwe 發表了，快來看看吧')
  end
end
