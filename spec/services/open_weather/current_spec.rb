require 'rails_helper'

RSpec.describe OpenWeather::Current do
  let(:open_weather) { described_class.new }
  let(:city) { 'Curitiba' }
  let(:country) { 'BR' }

  describe '#city' do
    describe 'correct parameters' do
      it 'returns the object with the right parameters',
         vcr: { cassette_name: 'open_weather_valid_city' } do
        response = open_weather.city(city: city, country: country)
        expect(response.cod).to eql 200
        expect(response.name).to eql city
        expect(response).to respond_to(:coord)
        expect(response).to respond_to(:weather)
        expect(response).to respond_to(:base)
        expect(response).to respond_to(:main)
        expect(response).to respond_to(:visibility)
        expect(response).to respond_to(:wind)
        expect(response).to respond_to(:clouds)
        expect(response).to respond_to(:sys)
      end
    end

    describe 'errors' do
      context 'invalid API key' do
        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_invalid_api_key' } do
          open_weather = described_class.new(api_key: 'test')
          response = open_weather.city(city: city)
          expect(response.cod).to eql 401
          expect(response.message).to eql 'Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.'
        end
      end

      context 'invalid city' do
        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_invalid_city' } do
          response = open_weather.city(
            city: 'tottalyinvalidcityname',
            country: 'BR'
          )
          expect(response.cod).to eql '404'
          expect(response.message).to eql 'city not found'
        end
      end

      context 'empty city' do
        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_empty_city' } do
          response = open_weather.city(city: '')
          expect(response.cod).to eql '400'
          expect(response.message).to eql 'Nothing to geocode'
        end
      end
    end
  end
end
