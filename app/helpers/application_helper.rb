# frozen_string_literal: true

# Rails' default application helper module
module ApplicationHelper
  def unit_code
    case session[:unit]
    when 'metric' then
      'C'
    when 'imperial'
      'F'
    else
      'K'
    end
  end

  def wind_unit_code
    case session[:unit]
    when 'imperial'
      'miles/hour'
    else
      'meters/second'
    end
  end
end
