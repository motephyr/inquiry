class Account::WorksController < ApplicationController
  layout "user_info", only: [:show]


  def show
    @user = User.friendly.find_by_slug!(params[:user_info_id])
    @user_info = @user.user_info
    @work = @user.works.friendly.find_by_slug!(params[:id])
  end
end
