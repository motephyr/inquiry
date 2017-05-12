class AcitvityMailer < ApplicationMailer
  include Roadie::Rails::Mailer

  def unlogin_notification(user,content)
    @user = user
    @content  = content
    roadie_mail(to: @user.email, subject: 'Conkwe 動態')
  end
end
