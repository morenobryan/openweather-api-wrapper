class WeatherController < ApplicationController
  def random
    @weather = OpenWeather::Current.new.random
    render 'weather'
  end

  def city
    @weather = OpenWeather::Current.new.city(
      city: weather_params[:city],
      country: weather_params[:country]
    )
    render 'weather'
  end

  private

  def weather_params
    params.fetch(:weather, {})
  end
end
