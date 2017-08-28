# frozen_string_literal: true

# Controller for weather-related requests
class WeatherController < ApplicationController
  def random
    latitude = Random.rand(-90.0..90.0)
    longitude = Random.rand(-180.0..180.0)
    cache_key = "coordinates/#{latitude}/#{longitude}/#{@unit}"

    @weather = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      OpenWeather::Current.new(units: @unit).coordinates(
        latitude: latitude,
        longitude: longitude
      )
    end

    render 'weather'
  end

  def city
    city = weather_params[:city]
    country = weather_params[:country]
    cache_key = "city/#{city}/#{country}/#{@unit}"

    @weather = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
      OpenWeather::Current.new(units: @unit).city(
        city: city,
        country: country
      )
    end

    render 'weather'
  end

  def unit
    session[:unit] = params[:unit]

    redirect_back fallback_location: root_path
  end

  private

  def weather_params
    params.fetch(:weather, {})
  end
end
