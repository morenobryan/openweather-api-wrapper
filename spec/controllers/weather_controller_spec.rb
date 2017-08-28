# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #random' do
    it 'gets the weather from a random location and returns sucess status',
       vcr: { cassette_name: 'open_weather_valid_coordinates' } do
      allow(Random).to receive(:rand).and_return(-25.5)
      get :random

      expect(response).to have_http_status :success
    end
  end

  describe 'GET #unit' do
    it 'sets the session variable with the passed parameter' do
      get :unit, params: { unit: 'metric' }

      expect(response).to redirect_to(root_path)
      expect(session['unit']).to eql 'metric'
    end

    it 'redirects to root path when there is no referer' do
      get :unit
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST #city' do
    it 'gets the weather info and returns a success status', vcr: { cassette_name: 'open_weather_valid_city' } do
      post :city, params: { weather: { city: 'Curitiba', country: 'BR' } }

      expect(response).to have_http_status :success
    end
  end
end
