# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  email                          :string(255)      default("")           # Email
#  encrypted_password             :string(255)      default("")
#  reset_password_token           :string(255)
#  reset_password_sent_at         :datetime
#  remember_created_at            :datetime
#  sign_in_count                  :integer          default(0)
#  current_sign_in_at             :datetime
#  last_sign_in_at                :datetime
#  current_sign_in_ip             :string(255)
#  last_sign_in_ip                :string(255)
#  fb_token                       :text
#  provider                       :string(255)                            # 固定為 facebook
#  uid                            :string(255)                            # facebook uid
#  name                           :string(255)                            # 姓名
#  username                       :string(255)
#  display_name                   :string(255)
#  gender                         :string(255)
#  first_name                     :string(255)
#  last_name                      :string(255)
#  description                    :text
#  about                          :text
#  policy                         :text
#  birthday                       :date
#  website                        :text
#  facebook_data                  :hstore           default({}), not null
#  twitter_data                   :hstore           default({}), not null
#  country                        :string(255)
#  location                       :string(255)
#  address                        :string(255)
#  phone                          :string(255)
#  locale                         :string(255)
#  currency                       :string(255)
#  state                          :string(255)
#  role                           :string(255)
#  category                       :string(255)
#  otp_secret_key                 :string(255)
#  otp_created_at                 :datetime
#  authenticate_otp_at            :datetime
#  confirmation_token             :string(255)
#  confirmed_at                   :datetime
#  confirmation_sent_at           :datetime
#  unconfirmed_email              :string(255)
#  invitation_token               :string(255)
#  invitation_created_at          :datetime
#  invitation_sent_at             :datetime
#  invitation_accepted_at         :datetime
#  invitation_limit               :integer
#  invited_by_id                  :integer
#  invited_by_type                :string(255)
#  current_access_at              :datetime
#  last_access_at                 :datetime
#  products_count                 :integer          default(0)
#  reviews_count                  :integer          default(0)
#  sales_orders_count             :integer          default(0)
#  purchase_orders_count          :integer          default(0)
#  conversations_count            :integer          default(0)
#  business_time                  :hstore           default({}), not null
#  data                           :hstore           default({}), not null
#  notification_data              :hstore           default({}), not null
#  shipping_options               :hstore           default([]), not null
#  social_options                 :hstore           default([]), not null
#  created_at                     :datetime
#  updated_at                     :datetime
#  avatar                         :string(255)
#  avatar_meta                    :hstore           default({}), not null
#  avatar_tmp                     :string(255)
#  avatar_processing              :boolean
#  receipt_data                   :hstore           default({}), not null
#  instagram_screen_name          :string(255)                            # Instagram Username
#  seven_eleven_shipping_settings :hstore           default({}), not null
#  cached_followings_count        :integer          default(0)
#  over18                         :boolean          default(FALSE)
#

require 'rails_helper'

describe User do
  it "should send welcome email when created" do
    # expect {
    #   FactoryGirl.create(:user)
    # }.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
  end

  it "should not allow user to created with blank email" do
    expect {
      FactoryGirl.create(:user, email: "")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should validate email format" do
    expect {
      FactoryGirl.create(:user, email: "123")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "#avatar_link" do
    context "when user without fb_uid" do
      pending "add some examples to (or delete) #{__FILE__}"

      # expect(FactoryGirl.create(:user).avatar_link).to eq(User.default_avatar_link)
    end
  end
end
