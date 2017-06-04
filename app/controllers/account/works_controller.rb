class Account::WorksController < ApplicationController

  def index
    @works = current_user.cares.where(careable_type: 'Work').includes(careable: [:user, :cares]).recent.map{|x| x.careable}
  end

  def show

    @user = User.friendly.find_by_slug!(params[:user_info_id])
    @user_info = @user.user_info
    @work = @user.works.includes(work_messages: :user).friendly.find_by_slug!(params[:id])

    @work_message = WorkMessage.new
    Work.increment_counter(:hits, @work.id)

    respond_to do |f|
      f.html { set_page_info({title: @work.subject, description: @work.content,image: @work.attach_avatar.try(:url)}) }
      f.js
    end
    # render layout: "user_info"

  end

  def new
    @work = current_user.works.build
    never_edit_info
  end

  def create
    @work = current_user.works.build(work_params)
    @work.category = current_user.user_info.category
    never_edit_info
    if @work.save
      flash[:error] = '如要公開作品，請記得設為公開發佈哦！'
      redirect_to account_user_info_work_path(@work.user, @work)
    else
      render :new
    end
  end

  def edit
    @work = current_user.works.friendly.find_by_slug!(params[:id])
    never_edit_info

  end

  def update
    @work = current_user.works.friendly.find_by_slug!(params[:id])
    never_edit_info
    if @work.update(work_params)
      flash[:error] = '如要公開作品，請記得設為公開發佈哦！'
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

  def never_edit_info
    @user_info = @work.user.user_info

    unless @user_info
      flash[:notice] = '您尚未編輯個人資料'
      redirect_to edit_info_account_user_infos_path
    end
  end
end
