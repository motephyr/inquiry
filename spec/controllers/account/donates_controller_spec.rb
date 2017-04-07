require 'rails_helper'

RSpec.describe Account::DonatesController, type: :controller do

  describe "GET #donor" do
    it "returns http success" do
      get :donor
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #bedonor" do
    it "returns http success" do
      get :bedonor
      expect(response).to have_http_status(:success)
    end
  end

end
