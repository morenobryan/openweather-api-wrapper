# frozen_string_literal: true

# Rails' default application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initialize_unit

  private

  def initialize_unit
    session[:unit] ||= 'metric'
    @unit = session[:unit]
  end
end
