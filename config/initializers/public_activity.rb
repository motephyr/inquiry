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
  belongs_to :appraisal, -> { joins(:activities).where(activities: {trackable_type: 'Appraisal'}) }, foreign_key: 'trackable_id'
  belongs_to :appraisal_message, -> { joins(:activities).where(activities: {trackable_type: 'AppraisalMessage'}) }, foreign_key: 'trackable_id'


  def record_intercom_event
    if recipient_id.nil?
      ActivityBroadcastJob.perform_now self
    end
  end
end