class DonatesController < ApplicationController

  before_action :login_required


  def new
    @work = Work.friendly.find_by_slug!(params[:work_id])
    @donate = current_user.donor_donates.build(work_id: @work.id, bedonor_id: @work.user_id)
    @donate_info = @donate.build_info
  end


  def create
    @work = Work.friendly.find_by_slug!(params[:work_id])
    @donate = current_user.donor_donates.build(donate_params)
    @donate.work_id = @work.id
    @donate.bedonor_id = @work.user_id
    @donate.set_price_by_kind

    if donate_params[:has_info] == "1"
      @donate.build_info(info_params[:info_attributes])
    end

    if @donate.save
      redirect_to user_info_work_path(@work.user, @work)
    else
      render :new
    end

  end

  def donate_params
    params.require(:donate).permit(:kind, :has_info)
  end

  def info_params
    params.require(:donate).permit(info_attributes: [:name, :address])
  end
end
