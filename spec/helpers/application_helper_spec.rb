# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'temperature_unit_code' do
    it 'returns C when session temperature unit is metric' do
      session[:temperature_unit] = 'metric'
      expect(helper.temperature_unit_code).to eql 'C'
    end

    it 'returns F when session temperature unit is metric' do
      session[:temperature_unit] = 'imperial'
      expect(helper.temperature_unit_code).to eql 'F'
    end

    it 'returns K when session temperature unit is anything else' do
      session[:temperature_unit] = nil
      expect(helper.temperature_unit_code).to eql 'K'
    end
  end
end
