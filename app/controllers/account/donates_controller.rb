class Account::DonatesController < ApplicationController
  layout "account", only: [:donor, :bedonor]

  def donor
    @donor_donates = current_user.donor_donates
  end

  def bedonor
    @bedonor_donates = current_user.bedonor_donates
  end
end
