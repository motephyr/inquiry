class Account::WorksController < ApplicationController
  layout "user_info", only: [:show]


  def show
    @user = User.friendly.find_by_slug!(params[:user_info_id])
    @user_info = @user.user_info
    @work = @user.works.friendly.find_by_slug!(params[:id])
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

  def edit
    @work = current_user.works.friendly.find_by_slug!(params[:id])
  end

  def update
    @work = current_user.works.friendly.find_by_slug!(params[:id])
    if @work.update(work_params)
      redirect_to account_user_info_path(current_user)
    else
      render :edit
    end
  end

  private
  def work_params
    params.require(:work).permit(:subject, :content, {attach_avatars: []}, :attach_content, :attach_url)
  end
end
