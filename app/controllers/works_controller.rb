class WorksController < ApplicationController

  before_action :login_required, only: [:getUrl, :update_care ]
  before_action :work_owner, only: [:update_published]
  before_action only: [:index, :newest, :favorite] do
    if params[:category_id].blank? && current_user && current_user.try(:user_info).try(:category_id) && (current_user.try(:user_info).try(:category_id) != 12)
      redirect_to request.path_info + "?category_id=" + current_user.user_info.category_id.to_s
    end
    set_page_info({title: "工作成果與作品列表", description: "每個人在工作上都有自已專精的領域，將你近期的工作成果展現給大家看，讓別人知道你擅長和拿手的是什麼，說不定他正需要你！"})
  end
  layout :determine_layout


  def category_page
    #編輯選擇
    @unlike = current_user ? current_user.votes.down.by_type('User').map{|x| x.votable.id} : nil
    if params[:pagekind] == "newest"
      if params[:category_id]
        @works = works(params).where.not(user: @unlike).is_published.order_by_new.page(params[:page])

      else
        #最新一個作者只會出現一個
        test = works(params).from('works').joins(', (select w.user_id, max(w.created_at) as time from works w left join users u on w.user_id = u.id group by w.user_id) as t')
        .joins(', users AS u')
        .where('works.created_at = t.time and works.user_id = u.id')
        .select('works.*')
        if @unlike.present?
          test =  test.where.not("works.user_id in (?)", @unlike)
        end
        @works = test.is_published.order_by_new.page(params[:page])
      end
    elsif params[:pagekind] == "favorite"
      @works = works(params).where.not(user: @unlike).is_published.order_by_favorite.page(params[:page])
    else
      @works = works(params).where.not(user: @unlike).is_published.is_featured.order_by_new.page(params[:page])
    end

    render :index


  end

  def index
    #編輯選擇
    @unlike = current_user ? current_user.votes.down.by_type('User').map{|x| x.votable.id} : nil
    if params[:pagekind] == "newest"
      if params[:category_id]
        @works = works(params).where.not(user: @unlike).is_published.order_by_new.page(params[:page])

      else
        #最新一個作者只會出現一個
        test = works(params).from('works').joins(', (select w.user_id, max(w.created_at) as time from works w left join users u on w.user_id = u.id group by w.user_id) as t')
        .joins(', users AS u')
        .where('works.created_at = t.time and works.user_id = u.id')
        .select('works.*')
        if @unlike.present?
          test =  test.where.not("works.user_id in (?)", @unlike)
        end
        @works = test.is_published.order_by_new.page(params[:page])
      end
    elsif params[:pagekind] == "favorite"
      @works = works(params).where.not(user: @unlike).is_published.order_by_favorite.page(params[:page])
    else
      @works = works(params).where.not(user: @unlike).is_published.is_featured.order_by_new.page(params[:page])
    end

    render :category_page

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

  def works(params)
    if params[:category_id]
      if params[:category_id] == 'all'
        works = Work.includes(:user, :cares)
      else
        works = Work.includes(:user, :cares).where(category_id: params[:category_id])
      end
    else
      works = Work.includes(:user, :cares)
    end
  end

  def determine_layout
    if action_name == 'index'
      "personal_page"
    end
  end

end
