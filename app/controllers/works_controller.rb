class WorksController < ApplicationController

  def index
    @works = Work.includes(:user, :cares).order_by_new
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

  def carers
    @work = Work.includes(:user, :cares).friendly.find_by_slug!(params[:id])
  end

end
