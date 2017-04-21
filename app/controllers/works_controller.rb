class WorksController < ApplicationController

  before_action :login_required, only: [:getUrl, :update_care ]
  before_action :work_owner, only: [:update_published]

  def index
    #編輯選擇
    @works = Work.includes(:user, :cares).is_published.is_featured.order_by_new
  end

  def newest
    #全部最新
    @works = Work.includes(:user, :cares).is_published.order_by_new
  end

  def favorite
    #照like數排序
    @works = Work.includes(:user, :cares).is_published.order_by_favorite
  end


  def getUrl
    begin
      object = LinkThumbnailer.generate(params[:attach_url].strip)
      message = 'ok'
    rescue LinkThumbnailer::Exceptions => e
      message = '找不到資料哦'
    end
    respond_to do |format|
      format.json { render :status => 200, :json => { :message => message, object: object } }
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
