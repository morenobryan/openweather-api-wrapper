class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_temperature_unit

  private

  def initialize_temperature_unit
    session[:temperature_unit] ||= 'metric'
    @temp_unit = session[:temperature_unit]
  end
end
