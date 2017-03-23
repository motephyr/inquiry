class AppraisalsController < ApplicationController

  before_action :login_required, except: [:index, :show ]
  before_action :appraisal_owner, only: [:edit, :update, :destroy]

  def index
    @appraisals = Appraisal.includes(category: :parent_category).all
  end

  def show
    @appraisal = Appraisal.find(params[:id])

    @appraisal_messages = @appraisal.appraisal_messages.includes(:user).all
    @appraisal_message = AppraisalMessage.new

    @appraisal_prices = @appraisal.appraisal_prices.all
    price = @appraisal.appraisal_prices.find_by(user: current_user)

    @appraisal_price = price.present? ? price : AppraisalPrice.new
  end

  def new
    @appraisal = current_user.appraisals.build
  end

  def edit
  end

  def create
    @appraisal = current_user.appraisals.build(appraisal_params)
    if @appraisal.save
      redirect_to appraisals_path
    else
      render :new
    end
  end

  def update
    if @appraisal.update(appraisal_params)
      redirect_to appraisal_path(@appraisal)
    else
      render :edit
    end
  end

  def destroy

    @appraisal.destroy

    redirect_to appraisals_path
  end

  private

  def appraisal_params
    params.require(:appraisal).permit(:category_id, :title, :description)
  end

  def appraisal_owner
    @appraisal = Appraisal.find(params[:id])
    unless @appraisal.user_id == current_user.id
      flash[:notice] = '你不是這個資料的使用者'
      redirect_to appraisals_path
    end
  end


end
