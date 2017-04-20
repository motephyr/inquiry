class Account::WorksController < ApplicationController


  def show

    @user = User.friendly.find_by_slug!(params[:user_info_id])
    @user_info = @user.user_info
    @work = @user.works.includes(work_messages: :user).friendly.find_by_slug!(params[:id])

    @work_message = WorkMessage.new
    Work.increment_counter(:hits, @work.id)

    respond_to do |f|
      f.html
      f.js
    end
    render layout: "user_info"
  end

  def new
    @work = current_user.works.build
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      flash[:notice] = '如要公開作品，請記得在左邊功能列設為公開發佈哦！'
      redirect_to account_user_info_work_path(@work.user, @work)
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
      flash[:notice] = '如要公開作品，請記得在左邊功能列設為公開發佈哦！'
      redirect_to account_user_info_work_path(@work.user, @work)
    else
      render :edit
    end
  end

  def destroy
    @work = current_user.works.friendly.find_by_slug!(params[:id])
    @work.destroy
    redirect_to account_user_info_path(current_user)
  end

  private
  def work_params
    params.require(:work).permit(:subject, :content, :attach_avatar, :attach_content, :attach_url, :remote_attach_avatar_url, :remote_image_url, :remote_description)
  end
end
