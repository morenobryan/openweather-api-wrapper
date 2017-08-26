# frozen_string_literal: true

module OpenWeather
  # Class to retrive the OpenWeather's current weather
  class Current < Base
    def city(city:, country: nil)
      response = self.class.get(
        '/weather',
        query: @options.merge(q: [city, country].compact.join(','))
      )
      handle_response(response)
    end

    def coordinates(latitude:, longitude:)
      response = self.class.get(
        '/weather',
        query: @options.merge(lat: latitude, lon: longitude)
      )
      handle_response(response)
    end
  end
end
