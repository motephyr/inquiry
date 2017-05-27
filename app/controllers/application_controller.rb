class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location
  def login_required
    if current_user.blank?
      respond_to do |format|
        format.html {
          authenticate_user!
        }
        format.js {
          render :partial => "common/not_logined"
        }
        format.all {
          head(:unauthorized)
        }
      end
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :image_cache])
  end

  def after_sign_in_path_for resource
    if resource_name == :user
      @user_info = current_user.user_info
      if @user_info.nil?
        flash[:notice] = '您尚未編輯個人資料，編輯一下吧！'
        edit_info_account_user_infos_path
      else
        session[:previous_url] || root_path
      end
    else
      super
    end
  end

  def store_location
    # store last url as long as it isn't a /users path
    if request.fullpath != '/'
      session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
    end
  end

  def set_page_info(object = nil)
    title = object.try(:[], :title)
    description = object.try(:[], :description) || "freelancer 作品 展示 人脈 媒合 咨詢 接案 教學，我們聚集那些願意透過工作得到自由的人們。促進討論，連結新的人脈。讓需要解決問題的人，找到能解決問題的人。讓有時間可以處理事情的人，幫忙沒時間處理事情的人。"
    image = object.try(:[], :image) || "#{Setting.domain}/ms-icon-310x310.png"

    set_page_title       title || '關於'
    set_page_description description

    @og = {title: title || "Conkwe - 自由工作者 工作，接案，人脈媒合平台",
      type:"website",
      url: "#{request.protocol}#{request.host_with_port}#{request.fullpath}",
      image: image,
      site_name: Setting.app_name,
      description: description,
      fb_admins: Setting.facebook_admins,
      fb_app_id: Setting.FACEBOOK_APP_ID
    }
  end

end
