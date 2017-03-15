class AppraisalMessagesController < ApplicationController
  before_action :login_required
  # before_action :message_owner, only: [:update, :destroy]
  before_action :message_owner, only: [:destroy]

  def create
    @appraisal_message = current_user.appraisal_messages.build(allowed_params)
    @appraisal_message.save
    respond_to do |f|
      f.js
    end
  end

  # def update
  #   @appraisal_message.update_attributes!(allowed_params)

  #   respond_to do |f|
  #     f.js
  #   end
  # end

  def destroy
    @appraisal_message.destroy

    respond_to do |f|
      f.js
    end
  end

  def allowed_params
    params.require(:appraisal_message).permit(:content, :appraisal_id)
  end

  def message_owner
    @appraisal_message = AppraisalMessage.find(params[:id])
    unless @appraisal_message.user_id == current_user.id
      flash[:notice] = '你不是這個留言的使用者'
      redirect_to appraisal_path(@appraisal_message.appraisal)
    end
  end

end
