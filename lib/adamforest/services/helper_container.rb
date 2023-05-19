# frozen_string_literal: true

require_relative "helper_mock"

class HelperContainer < Module
  def initialize(service = HelperMock)
    @@service = service
  end

  private

  attr_reader :service
end