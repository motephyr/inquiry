class AppraisalMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appraisal_message_#{params[:pathname]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
