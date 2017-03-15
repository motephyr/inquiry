class AppraisalPricesController < ApplicationController
  before_action :login_required
  before_action :price_owner, only: [:update]

  def create
    @appraisal_price = current_user.appraisal_prices.build(allowed_params)

    @appraisal_price.save
    redirect_to @appraisal_price.appraisal
  end

  def update

    @appraisal_price.update(allowed_params)
    redirect_to @appraisal_price.appraisal
  end

  def allowed_params
    params.require(:appraisal_price).permit(:price, :appraisal_id)
  end

  def price_owner
    @appraisal_price = AppraisalPrice.find(params[:id])
    unless @appraisal_price.user_id == current_user.id
      flash[:notice] = '你不是這個留言的使用者'
      redirect_to appraisal_path(@appraisal_price.appraisal)
    end
  end

end
