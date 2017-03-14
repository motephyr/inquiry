class AppraisalMessagesController < ApplicationController

  def create
    @appraisal_message = AppraisalMessage.new(allowed_params)
    @appraisal_message.user = current_user
    @appraisal_message.save
    respond_to do |f|
      f.js
    end
  end

  def destroy
    @appraisal_message = AppraisalMessage.destroy(params[:id])

    respond_to do |f|
      f.js
    end
  end

  def allowed_params
    params.require(:appraisal_message).permit(:content, :appraisal_id)
  end

end
