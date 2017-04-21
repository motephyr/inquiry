class AppraisalsController < ApplicationController

  before_action :login_required, except: [:index, :show ]
  before_action :appraisal_owner, only: [:edit, :update, :destroy]

  def index
    @appraisals = Appraisal.includes(category: :parent_category).order('created_at desc')
  end

  def show
    @appraisal = Appraisal.includes(appraisal_messages: :user).find(params[:id])

    @appraisal_message = AppraisalMessage.new

    @appraisal_prices = @appraisal.appraisal_prices.all
    @appraisal_price = @appraisal.appraisal_prices.find_or_initialize_by(user: current_user)

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
