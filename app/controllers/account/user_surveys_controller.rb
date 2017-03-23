class Account::UserSurveysController < ApplicationController

  def show
    @user = UserSurvey.find(params[:id])
  end
end
