# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenWeather::Current do
  let(:open_weather) { described_class.new(units: 'metric') }

  describe '#city' do
    let(:city) { 'Curitiba' }
    let(:country) { 'BR' }

    describe 'correct parameters' do
      it 'returns the object with the right parameters',
         vcr: { cassette_name: 'open_weather_valid_city' } do
        response = open_weather.city(city: city, country: country)
        expect(response.cod).to eql 200
        expect(response.name).to eql city
        expect(response).to respond_to(:forecast)
        expect(response).to respond_to(:description)
        expect(response).to respond_to(:icon)
        expect(response).to respond_to(:pressure)
        expect(response).to respond_to(:humidity)
        expect(response).to respond_to(:visibility)
        expect(response).to respond_to(:temp)
        expect(response).to respond_to(:temp_max)
        expect(response).to respond_to(:temp_min)
        expect(response).to respond_to(:clouds)
        expect(response).to respond_to(:datetime)
        expect(response).to respond_to(:wind)
      end
    end

    describe 'errors' do
      context 'invalid API key' do
        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_invalid_api_key' } do
          open_weather = described_class.new(api_key: 'test', units: 'metric')
          response = open_weather.city(city: city)
          message = 'Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.'
          expect(response.cod).to eql 401
          expect(response.message).to eql message
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

  describe '#coordinates' do
    describe 'correct parameters' do
      it 'returns the object with the right parameters',
         vcr: { cassette_name: 'open_weather_valid_coordinates' } do
        response = open_weather.coordinates(latitude: -49.29, longitude: -25.5)
        expect(response.cod).to eql 200
        expect(response).to respond_to(:name)
        expect(response).to respond_to(:forecast)
        expect(response).to respond_to(:description)
        expect(response).to respond_to(:icon)
        expect(response).to respond_to(:pressure)
        expect(response).to respond_to(:humidity)
        expect(response).to respond_to(:visibility)
        expect(response).to respond_to(:temp)
        expect(response).to respond_to(:temp_max)
        expect(response).to respond_to(:temp_min)
        expect(response).to respond_to(:clouds)
        expect(response).to respond_to(:datetime)
        expect(response).to respond_to(:wind)
      end
    end

    describe 'errors' do
      context 'invalid coordinates' do
        it 'returns an error message if the latitude is invalid',
           vcr: { cassette_name: 'open_weather_invalid_latitude' } do
          response = open_weather.coordinates(latitude: -91, longitude: 0)
          expect(response.cod).to eql '400'
          expect(response.message).to eql '-91 is not a float'
        end

        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_invalid_longitude' } do
          response = open_weather.coordinates(latitude: 0, longitude: -181)
          expect(response.cod).to eql '400'
          expect(response.message).to eql '-181 is not a float'
        end
      end

      context 'empty coordinates' do
        it 'returns an error message with code',
           vcr: { cassette_name: 'open_weather_empty_coordinates' } do
          response = open_weather.coordinates(latitude: nil, longitude: nil)
          expect(response.cod).to eql '400'
          expect(response.message).to eql 'Nothing to geocode'
        end
      end
    end
  end
end
