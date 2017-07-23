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
      JSON.parse(response.body, object_class: OpenStruct)
    end
  end
end
