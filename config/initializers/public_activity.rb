# module PublicActivity
#   class Activity
#     after_create do
#       logger.info "AAA"
#       logger.info self
#       # HogeHogeMailer.send_mail(self.trackable).deliver
#       ActivityBroadcastJob.perform_later self
#     end
#   end
# end

PublicActivity::Activity.class_eval do
  after_create :record_intercom_event

  def record_intercom_event
      ActivityBroadcastJob.perform_now self
  end
end