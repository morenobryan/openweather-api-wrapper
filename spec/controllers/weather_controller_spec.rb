require 'rails_helper'

RSpec.describe WeatherController, type: :controller do

  describe "GET #random" do
    it "returns http success" do
      get :random
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #city" do
    it "returns http success" do
      get :city
      expect(response).to have_http_status(:success)
    end
  end

end
