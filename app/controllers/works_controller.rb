class WorksController < ApplicationController

  def index
    @works = Work.includes(:user).all
  end

end
