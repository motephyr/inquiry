class AcitvityMailer < ApplicationMailer
  include Roadie::Rails::Mailer
  helper :application # 這樣會載入 app/helpers/application_helper.rb
  

  def unlogin_notification(user,content)
    @user = user
    @content  = content
    roadie_mail(to: @user.email, subject: 'Conkwe 動態')
  end

  def works_notification(user, content)
  	# ...
    @user = user
    @content  = content
    
    roadie_mail(to: @user.email, subject: 'Conkwe 動態')
  end
end
