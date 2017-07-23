module OpenWeather
  class Current < Base
    def city(city:, country: nil)
      response = self.class.get(
        '/weather',
        query: @options.merge(q: [city, country].compact.join(','))
      )
      handle_response(response)
    end
  end
end
