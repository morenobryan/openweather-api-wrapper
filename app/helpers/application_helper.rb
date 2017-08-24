module ApplicationHelper
  def temperature_unit_code
    case session[:temperature_unit]
    when 'metric' then
      'C'
    when 'imperial'
      'F'
    else
      'K'
    end
  end
end
