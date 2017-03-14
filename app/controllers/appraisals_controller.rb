class AppraisalsController < ApplicationController
  def index
    @appraisal = Appraisal.all
  end

  def show
    @appraisal = Appraisal.find(params[:id])
  end

  def new
    @appraisal = Appraisal.new
  end

  def edit
    @appraisal = Appraisal.find(params[:id])
  end

  def create
    @appraisal = Appraisal.new(appraisal_params)
    if @appraisal.save
      redirect_to appraisals_path
    else
      render :new
    end
  end

  def update
    @appraisal = Appraisal.find(params[:id])
    if @appraisal.update(appraisal_params)
      redirect_to appraisal_path(@appraisal)
    else
      render :edit
    end
  end

  def destroy
    @appraisal = Appraisal.find(params[:id])

    @appraisal.destroy

    redirect_to appraisals_path
  end

  private

  def appraisal_params
    params.require(:appraisal).permit(:title, :description)
  end



end
