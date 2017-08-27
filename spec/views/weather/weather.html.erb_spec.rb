# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather/weather.html.erb', type: :view do
  context 'failure message' do
    let(:weather) { OpenStruct.new(cod: 500, message: 'Fail') }

    it 'renders the failure message' do
      assign(:weather, weather)
      render
      expect(rendered).to include 'We\'re sorry, we couldn\'t fetch the weather for this location'
      expect(rendered).to include 'Here are more details: Fail'
    end
  end

  context 'success fetching of weather' do
    let(:weather) { OpenStruct.new(cod: 200, datetime: Time.current) }

    it 'renders "No City" when the result object does not have a name' do
      weather.name = ''
      assign(:weather, weather)
      render
      expect(rendered).to include 'No City'
    end

    it 'renders the city name when name is present' do
      weather.name = 'Curitiba'
      assign(:weather, weather)
      render
      expect(rendered).to include 'Weather in Curitiba'
    end

    it 'renders the forecast name and description' do
      weather.forecast = 'Mist'
      weather.description = 'Partly cloudy'
      assign(:weather, weather)
      render
      expect(rendered).to include 'Mist'
      expect(rendered).to include 'Partly cloudy'
    end

    it 'renders the temperature' do
      weather.temp = '20'
      weather.temp_max = '40'
      weather.temp_min = '5'
      assign(:weather, weather)
      render
      expect(rendered).to include '20'
      expect(rendered).to include '40'
      expect(rendered).to include '5'
    end

    context 'pressure' do
      it 'renders the pressure when present' do
        weather.pressure = '500'
        assign(:weather, weather)
        render
        expect(rendered).to include 'Pressure: <strong>500 hPa</strong>'
      end

      it 'renders nothing when pressure is not present' do
        weather.pressure = ''
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Pressure: <strong>500 hPa</strong>'
      end
    end

    context 'humidity' do
      it 'renders the humidity when present' do
        weather.humidity = '89'
        assign(:weather, weather)
        render
        expect(rendered).to include 'Humidity: <strong>89%</strong>'
      end

      it 'renders nothing when humidity is not present' do
        weather.humidity = ''
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Humidity: <strong>89%</strong>'
      end
    end

    context 'visibility' do
      it 'renders the visibility when present' do
        weather.visibility = '1000'
        assign(:weather, weather)
        render
        expect(rendered).to include 'Visibility: <strong>1000m</strong>'
      end

      it 'renders nothing when visibility is not present' do
        weather.visibility = ''
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Visibility: <strong>1000m</strong>'
      end
    end

    context 'wind speed' do
      it 'renders the wind speed when present' do
        weather.wind = OpenStruct.new(speed: '2')
        assign(:weather, weather)
        render
        expect(rendered).to include 'Wind Speed: <strong>2m/s</strong>'
      end

      it 'renders nothing when wind speed is not present' do
        weather.wind = OpenStruct.new(speed: '')
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Wind Speed: <strong>2m/s</strong>'
      end
    end

    context 'wind direction' do
      it 'renders the wind direction when present' do
        weather.wind = OpenStruct.new(deg: '123')
        assign(:weather, weather)
        render
        expect(rendered).to include 'Wind Direction: <strong>123°</strong>'
      end

      it 'renders nothing when wind direction is not present' do
        weather.wind = OpenStruct.new(deg: '')
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Wind Direction: <strong>123°</strong>'
      end
    end

    context 'clouds' do
      it 'renders the clouds when present' do
        weather.clouds = '15'
        assign(:weather, weather)
        render
        expect(rendered).to include 'Clouds: <strong>15%</strong>'
      end

      it 'renders nothing when clouds is not present' do
        weather.clouds = ''
        assign(:weather, weather)
        render
        expect(rendered).to_not include 'Clouds: <strong>15%</strong>'
      end
    end
  end
end
