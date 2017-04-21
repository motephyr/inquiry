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
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image])
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
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end


end
