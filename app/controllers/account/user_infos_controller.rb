class Account::UserInfosController < ApplicationController

  before_action :login_required, except: [:show]
  layout :determine_layout


  def show
    if current_user == User.friendly.find_by_slug!(params[:id])
      never_edit_my_info
    else
      never_edit_user_info
    end
    @works = (@user == current_user) ? @user.works.includes(:cares).order_by_new : @user.works.includes(:cares).is_published.order_by_new
  end

  def edit_status
    never_edit_my_info
  end

  def edit_info
    @user_info = current_user.user_info

    if @user_info.nil?
      @user_info = current_user.build_user_info
      if find_user_survey.present?
        flash[:notice] = '您的個人資料已經自動帶入囉！'
        @user_info.update(find_user_survey.attributes.except('id','user_id','created_at','updated_at').symbolize_keys)
      end
    end
  end

  def update_info
    @user_info = current_user.user_info.present? ? current_user.user_info : current_user.build_user_info

    if @user_info.update(user_info_params)
      redirect_to account_user_info_path(current_user)
    else
      render :edit
    end
  end

  def search
    @q = UserInfo.ransack(params[:q])
    @user_infos = @q.result(distinct: true).limit(10).map{|x| x if x.user.present? }.compact
  end

  private
  def find_user_survey
    user_survey = UserSurvey.find_by(email: current_user.email)
    user_survey ? UserInfo.new(user_survey.attributes.select{ |key, _| UserInfo.attribute_names.include? key }) : nil
  end

  def never_edit_user_info
    @user = User.friendly.find_by_slug!(params[:id])
    @user_info = @user.user_info
    unless @user_info
      flash[:notice] = '此使用者尚未編輯個人資料'
      redirect_back(fallback_location: root_path)
    end
  end

  def never_edit_my_info
    @user = User.find(current_user.id)
    @user_info = @user.user_info
    unless @user_info
      flash[:notice] = '您尚未編輯個人資料'
      redirect_to edit_info_account_user_infos_path
    end
  end

  private
  def user_info_params
    params.require(:user_info).permit(:user_id,:name, :work_content, :work_area, :typical_work, :teach, :speak, :labor, :contract, :category_id, :skill_tool)
  end

  def determine_layout
    if action_name == 'show'
      "user_info"
    elsif action_name == 'edit_status' || action_name == 'edit_info'
      'account'
    end
  end
end
