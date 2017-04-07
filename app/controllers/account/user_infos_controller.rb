class Account::UserInfosController < ApplicationController

  before_action :login_required, except: [:show]

  def show
    if current_user == User.friendly.find_by_slug!(params[:id])
      never_edit_my_info
    else
      never_edit_user_info
    end
    render layout: "user_info"
  end

  def edit_status
    never_edit_my_info
    render layout: "account"
  end

  def edit_info
    @user_info = current_user.user_info

    if @user_info.nil?
      @user_info = current_user.build_user_info
      if find_user_survey.present?
        @user_info = find_user_survey
      end
    end
    render layout: "account"
  end

  def update_info
    @user_info = current_user.user_info.present? ? current_user.user_info : current_user.build_user_info

    if @user_info.update(user_info_params)
      redirect_to account_user_info_path(current_user)
    else
      render :edit
    end
  end

  private
  def find_user_survey
    user_survey = UserSurvey.find_by(email: current_user.email)
    user_survey ? UserInfo.new(user_survey.attributes.select{ |key, _| UserInfo.attribute_names.include? key }) : nil
  end

  def never_edit_user_info
    @user_info = User.friendly.find_by_slug!(params[:id]).user_info
    unless @user_info
      flash[:notice] = '此使用者尚未編輯個人資料'
      redirect_back(fallback_location: root_path)
    end
  end

  def never_edit_my_info
    @user_info = current_user.user_info
    if @user_info.nil?
      flash[:notice] = '您尚未編輯個人資料'
      redirect_to edit_info_account_user_infos_path
    end
  end

  def user_info_params
    params.require(:user_info).permit(:user_id,:name, :work_content, :work_area, :typical_work, :teach, :speak, :labor, :contract, :category_id, :skill_and_tool)
  end
end
