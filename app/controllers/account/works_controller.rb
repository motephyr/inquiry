class Account::WorksController < ApplicationController
  def show
    @work = User.friendly.find_by_slug!(params[:user_info_id]).works.friendly.find_by_slug!(params[:id])
  end
end
