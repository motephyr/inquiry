class Account::AppraisalsController < ApplicationController
  before_action :login_required
  def index
    @appraisals = current_user.cares.includes(careable: [:user,category: :parent_category]).recent.map{|x| x.careable}
  end

  def update_care
    @appraisal = Appraisal.find(params[:id])
    if @appraisal.is_care_by? current_user
      @appraisal.uncare_by current_user
    else
      @appraisal.care_by current_user
    end
    redirect_to account_appraisals_path
  end
end
