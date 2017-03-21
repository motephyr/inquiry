class Account::UsersController < ApplicationController

  def show
    @user = UserInfo.find(params[:id])
  end

end
