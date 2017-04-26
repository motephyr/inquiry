class WorkMessagesController < ApplicationController
  before_action :login_required
  # before_action :message_owner, only: [:update, :destroy]
  before_action :message_owner, only: [:destroy]

  def create
    @work_message = current_user.work_messages.build(allowed_params)
    @work_message.save
    respond_to do |f|
      f.js
    end
  end

  # def update
  #   @work_message.update_attributes!(allowed_params)

  #   respond_to do |f|
  #     f.js
  #   end
  # end

  def destroy
    @work_message.destroy

    respond_to do |f|
      f.js
    end
  end

  def allowed_params
    params.require(:work_message).permit(:content, :work_id)
  end

  def message_owner
    @work_message = WorkMessage.find(params[:id])
    unless @work_message.user_id == current_user.id || @work_message.work.user_id == current_user.id
      flash[:notice] = '你不是這個留言的使用者'
      redirect_to work_path(@work_message.work)
    end
  end

end
