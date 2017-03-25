class AppraisalPricesController < ApplicationController
  before_action :login_required
  before_action :price_owner, only: [:destroy]

  def create
    @appraisal_price = current_user.appraisal_prices.build(allowed_params)

    if @appraisal_price.save
      flash[:notice] = '您輸入的金額是：' + @appraisal_price.price.to_s
    else
      flash[:notice] = '輸入錯誤囉'
    end

    redirect_to @appraisal_price.appraisal

  end

  def destroy

    @appraisal_price = AppraisalPrice.find(params[:id])
    @appraisal_price.destroy
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
