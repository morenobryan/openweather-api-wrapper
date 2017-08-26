# frozen_string_literal: true

# Rails' default Application record class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
