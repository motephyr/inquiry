class NewworksMailer < ApplicationMailer
  include Roadie::Rails::Mailer
  helper :application # 這樣會載入 app/helpers/application_helper.rb

  def newworks_notification(user, works)
    @user = user
    @works = works
    roadie_mail(to: @user.email, subject: 'Conkwe 動ss態')
  end
end
