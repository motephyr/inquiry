class WelcomeController < ApplicationController

  def index
    cookies["new_viewer"] = 'false'
    render layout: "landing_page"
  end

end