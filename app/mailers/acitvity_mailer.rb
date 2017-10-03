class AcitvityMailer < ApplicationMailer
  include Roadie::Rails::Mailer

  def unlogin_notification(user,content)
    @user = user
    @content  = content
    roadie_mail(to: @user.email, subject: 'Conkwe 動態')
  end

  def works_notification(user, works)
  	# ...
  	@user = user
    @works = works
    roadie_mail(to: @user.email, subject: 'Conkwe 動態')
  end
end
