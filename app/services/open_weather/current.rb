module OpenWeather
  class Current < Base
    def city(city:, country: nil)
      response = self.class.get(
        '/weather',
        query: @options.merge(q: [city, country].compact.join(','))
      )
      handle_response(response)
    end

    def random
      latitude = Random.rand(-90.0..90.0)
      longitude = Random.rand(-180.0..180.0)
      coordinates(latitude: latitude, longitude: longitude)
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
