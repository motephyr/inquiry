class AppraisalPricesController < ApplicationController

  def create
    @appraisal_price = current_user.appraisal_prices.build(allowed_params)

    @appraisal_price.save
    redirect_to @appraisal_price.appraisal
  end

  def update
    @appraisal_price = AppraisalPrice.find(params[:id])

    @appraisal_price.update(allowed_params)
    redirect_to @appraisal_price.appraisal
  end

  def allowed_params
    params.require(:appraisal_price).permit(:price, :appraisal_id)
  end

end
