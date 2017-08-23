module OpenWeather
  class Base
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5/'

    def initialize(params = {})
      @options = {
        appid: params[:api_key] || ENV['OPENWEATHER_API_KEY'],
        units: params[:units] || 'metric'
      }
    end

    def handle_response(response)
      format_response(JSON.parse(response.body, object_class: OpenStruct))
    end

    private

    def format_response(parsed_response)
      return parsed_response if parsed_response.cod != 200
      parsed_response.pressure = parsed_response.main.pressure
      parsed_response.humidity = parsed_response.main.humidity
      parsed_response.temp = parsed_response.main.temp
      parsed_response.temp_max = parsed_response.main.temp_max
      parsed_response.temp_min = parsed_response.main.temp_min
      parsed_response.clouds = parsed_response.clouds.all
      parsed_response.datetime = parsed_response.dt
      parsed_response.icon = parsed_response.weather.first.icon
      parsed_response.forecast = parsed_response.weather.first.main
      parsed_response.description = parsed_response.weather.first.description
      parsed_response
    end
  end
end
