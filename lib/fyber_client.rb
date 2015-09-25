require 'faraday'

module Fyber
  class Client
    def initialize
      @config = Rails.application.config_for(:fyber).try(:symbolize_keys)

      @conn = Faraday.new(url: 'http://api.fyber.com') do |faraday|
        faraday.request :json
        faraday.response :logger #:json, content_type: /\bjson$/
        faraday.use :instrumentation
        faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
