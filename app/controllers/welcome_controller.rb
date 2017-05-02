class WelcomeController < ApplicationController
  before_action :set_page_info,  only: [:index]

  def index
    cookies["new_viewer"] = 'false'
    @works = Work.includes(:user, :cares).is_published.is_featured.order_by_new.limit(8)

    render layout: "landing_page"
  end

end