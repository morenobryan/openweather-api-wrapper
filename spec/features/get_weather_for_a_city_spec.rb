# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'get weather for a city', type: :feature do
  it 'gets the weather for a valid city', vcr: { cassette_name: 'open_weather_valid_city' } do
    visit root_path

    within '.weather-search' do
      fill_in 'City', with: 'Curitiba'
      select 'Brazil', from: 'Country'

      click_button 'Get Weather'
    end

    expect(page).to have_content 'Weather in Curitiba'
    expect(page).to have_content 'Mist'
    expect(page).to have_content '283.77°C'
    expect(page).to have_content 'Max: 284.15°C'
    expect(page).to have_content 'Min: 283.15°C'
    expect(page).to have_content 'Pressure: 1025 hPa'
    expect(page).to have_content 'Humidity: 100%'
    expect(page).to have_content 'Visibility: 3000m'
    expect(page).to have_content 'Wind Speed: 2.1 meters/second'
    expect(page).to have_content 'Wind Direction: 70°'
    expect(page).to have_content 'Clouds: 75%'
  end

  it 'gets the weather for an invalid city', vcr: { cassette_name: 'open_weather_invalid_city' } do
    visit root_path

    within '.weather-search' do
      fill_in 'City', with: 'tottalyinvalidcityname'
      select 'Brazil', from: 'Country'

      click_button 'Get Weather'
    end

    expect(page).to have_content 'We\'re sorry, we couldn\'t fetch the weather for this location'
    expect(page).to have_content 'Here are more details: city not found'
  end
end
