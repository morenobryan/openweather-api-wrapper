class WeatherController < ApplicationController
  def random
    latitude = Random.rand(-90.0..90.0)
    longitude = Random.rand(-180.0..180.0)
    cache_key = "coordinates/#{latitude}/#{longitude}"

    @weather = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      OpenWeather::Current.new.coordinates(
        latitude: latitude,
        longitude: longitude
      )
    end

    render 'weather'
  end

  def city
    city = weather_params[:city]
    country = weather_params[:country]
    cache_key = "city/#{city}/#{country}"

    @weather = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      OpenWeather::Current.new.city(
        city: city,
        country: country
      )
    end

    render 'weather'
  end

  private

  def weather_params
    params.fetch(:weather, {})
  end
end
