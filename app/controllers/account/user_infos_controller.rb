class Account::UserInfosController < ApplicationController

  before_action :login_required, except: [:show, :search, :tag]
  layout :determine_layout

  def sip
    @user = User.friendly.find_by_slug!(params[:id])
  end

  def show
    if current_user == User.friendly.find_by_slug!(params[:id])
      never_edit_my_info
    else
      never_edit_user_info
    end
    @works = (@user == current_user) ? @user.works.includes(:cares).order("is_published desc").order_by_new : @user.works.includes(:cares).is_published.order_by_new

    render :personal_page
  end

  def unique
    if current_user == User.friendly.find_by_slug!(params[:id])
      never_edit_my_info
    else
      never_edit_user_info
    end
    @works = (@user == current_user) ? @user.works.includes(:cares).order("is_published desc").order_by_new : @user.works.includes(:cares).is_published.order_by_new
    filter_works = @works.select{|x| x.attach_avatar.present?}
    @main_image_url = filter_works[rand(0...filter_works.length)].attach_avatar.url
  end

  def personal_page
    if current_user == User.friendly.find_by_slug!(params[:id])
      never_edit_my_info
    else
      never_edit_user_info
    end

    if @user.fb_id && session[:token]
      graph = Koala::Facebook::API.new(session[:token])
      begin
        context_id = graph.get_object("/#{@user.fb_id}",{fields:"context.fields(all_mutual_friends.limit(100))"})["context"]["id"]
        @all_mutual_friends = graph.get_object("/#{context_id}/all_mutual_friends")
      rescue
        @all_mutual_friends = nil
      end
    end

    @works = (@user == current_user) ? @user.works.includes(:cares).order("is_published desc").order_by_new : @user.works.includes(:cares).is_published.order_by_new
    render :show
  end

  def edit_status
    never_edit_my_info
  end

  def edit_communication
    never_edit_my_info
    @user_phone = current_user.user_phone || current_user.build_user_phone
  end

  def update_communication
    @user_phone = current_user.user_phone.present? ? current_user.user_phone : current_user.build_user_phone

    if @user_phone.update(user_phone_params)

      redirect_to edit_communication_account_user_infos_path
    else
      render :edit_communication
    end
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

      redirect_to edit_status_account_user_infos_path
    else
      render :edit_info
    end
  end

  def search
    @q = UserInfo.ransack(params[:q])
    @user_infos = @q.result(distinct: true).page(params[:page])
    if @user_infos.length == 0
      flash[:notice] = '您搜尋的內容找不到對應的工作者哦'
    else
      flash[:notice] = nil
    end
  end

  def tag
    if params[:tag]
      @user_infos = UserInfo.tagged_with(params[:tag]).page(params[:page])
      if @user_infos.blank?
        flash[:notice] = '尚無人新增此項目哦'
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:notice] = '尚無人新增此項目哦'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def find_user_survey
    user_survey = UserSurvey.find_by(email: current_user.email)
    user_survey ? UserInfo.new(user_survey.attributes.select{ |key, _| UserInfo.attribute_names.include? key }) : nil
  end

  def never_edit_user_info
    @user = User.friendly.find_by_slug!(params[:id])
    @user_info = @user.user_info
    if @user_info.present?
      set_page_info({title: @user_info.nickname, description: "#{@user_info.work_area} #{@user_info.skill_list} #{@user_info.work_content}", image: @user.avatar_link(size: 400)})
    else
      flash[:notice] = '此使用者尚未編輯個人資料'
      redirect_back(fallback_location: root_path)
    end
  end

  def never_edit_my_info
    @user = User.find(current_user.id)
    @user_info = @user.user_info
    if @user_info.present?
      set_page_info({title: @user_info.nickname, description: "#{@user_info.work_area} #{@user_info.skill_list} #{@user_info.work_content}", image: @user.avatar_link(size: 400)})
    else
      flash[:notice] = '您尚未編輯個人資料'
      redirect_to edit_info_account_user_infos_path
    end
  end

  private
  def user_info_params

    state_list = params.require(:user_info).map do |x, y|
      if (y == "1" && (x == "teach" ||  x == "speak" ||  x == "labor" ||  x == "contract"))
        x
      elsif x == "category_id"
        Category.find(y.to_i).title
      end
    end.compact.join(',')

    skill_list = params.require(:user_info)[:skill_list].split(' ').compact.join(',')


    params.require(:user_info).permit(:user_id,:name, :work_content, :work_area, :typical_work, :teach, :speak, :labor, :contract, :category_id, :skill_tool, :alert).merge(skill_list: skill_list, state_list: state_list)
  end

  def user_phone_params
    params.require(:user_phone).permit(:minute_rate, :phone_number)
  end

  def determine_layout
    if action_name == 'show'
      "personal_page"
    elsif action_name == 'personal_page'
      "user_info"
    elsif action_name == 'edit_status' || action_name == 'edit_info' || action_name == 'edit_communication'
      'account'
    elsif action_name == "unique"
      "blank"
    end
  end
end
