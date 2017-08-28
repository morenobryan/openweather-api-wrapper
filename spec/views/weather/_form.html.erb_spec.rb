# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'weather/_form', type: :view do
  it 'renders both of the links' do
    render
    expect(rendered).to include 'Enter the city and the country of which you want the current weather'
    expect(rendered).to include 'City'
    expect(rendered).to include 'Country'
    expect(rendered).to include 'Get Weather'
    expect(rendered).to include 'Get a random location'
  end
end
