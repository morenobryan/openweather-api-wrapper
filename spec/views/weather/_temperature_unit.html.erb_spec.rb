# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather/_unit', type: :view do
  it 'renders both of the links' do
    render
    expect(rendered).to have_link '°C', href: unit_weather_index_path(unit: 'metric')
    expect(rendered).to have_link '°F', href: unit_weather_index_path(unit: 'imperial')
  end
end
