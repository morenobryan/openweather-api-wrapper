# frozen_string_literal: true

module OpenWeather
  # Class to be the base of OpenWeather's API wrapper
  class Base
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5/'

    ALIASES = {
      cod: 'cod',
      name: 'name',
      forecast: 'weather.first.main',
      description: 'weather.first.description',
      icon: 'weather.first.icon',
      pressure: 'main.pressure',
      humidity: 'main.humidity',
      visibility: 'visibility',
      temp: 'main.temp',
      temp_max: 'main.temp_max',
      temp_min: 'main.temp_min',
      clouds: 'clouds.all',
      datetime: 'dt',
      wind: 'wind'
    }.freeze

    def initialize(params = {})
      @options = {
        appid: params[:api_key] || ENV['OPENWEATHER_API_KEY'],
        units: params[:units]
      }
    end

    def handle_response(response)
      format_response(JSON.parse(response.body, object_class: OpenStruct))
    end

    private

    def format_response(parsed_response)
      return parsed_response if parsed_response.cod != 200
      formatted_response = OpenStruct.new
      ALIASES.each do |(key, value)|
        formatted_response.send("#{key}=", value.split('.').inject(parsed_response, :send))
      end
      formatted_response
    end
  end
end
