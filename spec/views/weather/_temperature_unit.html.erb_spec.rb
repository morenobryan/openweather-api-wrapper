# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather/_temperature_unit', type: :view do
  it 'renders both of the links' do
    render
    expect(rendered).to have_link '°C', href: temperature_unit_weather_index_path(temp_unit: 'metric')
    expect(rendered).to have_link '°F', href: temperature_unit_weather_index_path(temp_unit: 'imperial')
  end
end
