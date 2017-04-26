class WorksController < ApplicationController

  before_action :login_required, only: [:getUrl, :update_care ]
  before_action :work_owner, only: [:update_published]

  def index
    #編輯選擇
    @unlike = current_user.votes.down.by_type('User').map{|x| x.votable}
    @works = Work.includes(:user, :cares).where.not(user: @unlike).is_published.is_featured.order_by_new
  end

  def newest
    #全部最新
    @unlike = current_user.votes.down.by_type('User').map{|x| x.votable}
    @works = Work.includes(:user, :cares).where.not(user: @unlike).is_published.order_by_new
    # Work.includes(:user, :cares).from('users AS u').joins('INNER JOIN works AS w ON u.id = w.user_id').order('w.id DESC').select('w.*')
  end

  def favorite
    #照like數排序
    @unlike = current_user.votes.down.by_type('User').map{|x| x.votable}
    @works = Work.includes(:user, :cares).where.not(user: @unlike).is_published.order_by_favorite
  end


  def getUrl
    url = params[:attach_url].strip
    obj = helpers.get_resolved_url_obj(url)
    message = 'ok'
    type = nil
    if obj[:type] == "others"
      begin
        object = LinkThumbnailer.generate(url)
        type = "image"
      rescue LinkThumbnailer::Exceptions => e
        message = '找不到資料哦'
      end
    elsif obj[:type] == "image"
      object = { type: obj[:type], images: [ { src: "#{url}" } ] }
    elsif obj[:type] == "youtube"
      object = { type: obj[:type], media_url: "https://www.youtube.com/embed/#{obj[:match_object][1]}?rel=0" }
    else
      object = { type: obj[:type], media_url: url }
    end
    if type.nil?
      type = obj[:type]
    end
    respond_to do |format|
      format.json { render :status => 200, :json => { :message => message, object: object, type: type } }
    end
  end

  def update_care
    @work = Work.friendly.find_by_slug!(params[:id])
    if @work.is_care_by? current_user
      @work.uncare_by current_user
    else
      @work.care_by current_user
    end

    respond_to do |format|
      format.js
    end
  end

  def update_featured
    if current_user.try(:is_admin?)
      @work = Work.friendly.find_by_slug!(params[:id])
      if @work.is_featured?
        @work.update_attributes!(is_featured: false)
      else
        @work.update_attributes!(is_featured: true)
      end
    end

    redirect_to works_path
  end

  def update_published
    if @work.is_published?
      @work.update_attributes!(is_published: false)
    else
      @work.update_attributes!(is_published: true)
    end

    respond_to do |format|
      format.js
      format.html {redirect_to account_user_info_work_path(@work.user, @work)}
    end
  end

  def report
    @user = Work.friendly.find_by_slug!(params[:id]).user
    if current_user.disliked? @user
      @user.undisliked_by current_user
    else
      @user.disliked_by current_user
    end
    redirect_back(fallback_location: root_path)
  end

  def carers
    @work = Work.includes(:user, :cares).friendly.find_by_slug!(params[:id])
  end

  def work_owner
    @work = Work.friendly.find_by_slug!(params[:id])
    unless @work.user_id == current_user.id
      flash[:notice] = '你不是這個資料的使用者'
      redirect_to works_path
    end
  end

end
