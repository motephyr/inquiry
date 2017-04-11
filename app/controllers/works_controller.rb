class WorksController < ApplicationController

  def index
    @works = Work.includes(:user).all
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

end
