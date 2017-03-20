class Account::UsersController < ApplicationController

  def show
    @user = UserSurvey.find(params[:id])
  end

end
