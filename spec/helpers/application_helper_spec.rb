# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'unit_code' do
    it 'returns C when session temperature unit is metric' do
      session[:unit] = 'metric'
      expect(helper.unit_code).to eql 'C'
    end

    it 'returns F when session temperature unit is metric' do
      session[:unit] = 'imperial'
      expect(helper.unit_code).to eql 'F'
    end

    it 'returns K when session temperature unit is anything else' do
      session[:unit] = nil
      expect(helper.unit_code).to eql 'K'
    end
  end

  describe 'wind_unit_code' do
    it 'returns meters/second when session temperature unit is metric' do
      session[:unit] = 'metric'
      expect(helper.wind_unit_code).to eql 'meters/second'
    end

    it 'returns miles/hour when session temperature unit is metric' do
      session[:unit] = 'imperial'
      expect(helper.wind_unit_code).to eql 'miles/hour'
    end

    it 'returns meters/second when session temperature unit is anything else' do
      session[:unit] = nil
      expect(helper.wind_unit_code).to eql 'meters/second'
    end
  end
end
