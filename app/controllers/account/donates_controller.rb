class Account::DonatesController < ApplicationController

  def donor
    @donor_donates = current_user.donor_donates
    render layout: "account"
  end

  def bedonor
    @bedonor_donates = current_user.bedonor_donates
    render layout: "account"
  end
end
