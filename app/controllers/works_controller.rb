class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def new
    @work = current_user.works.build
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      redirect_to account_user_info_path(current_user)
    else
      render :new
    end
  end

  private
  def work_params
    params.require(:work).permit(:subject, :content)
  end

end
