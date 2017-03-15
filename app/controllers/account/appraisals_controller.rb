class Account::AppraisalsController < ApplicationController
  before_action :login_required
  def index
    @appraisals = current_user.appraisals.recent
  end
end
