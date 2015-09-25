require 'fyber_client'

class OfferController < ApplicationController
  def index
    search_params = { timestamp: Time.current.to_i.to_s }
    search_params.merge! params.try(:[], :offer).try(:symbolize_keys) || {}

    # since we're no using active record, use openstruct to take benefit from rails form management
    @offer = OpenStruct.new(search_params)

    fclient = Fyber::Client.new
    res = fclient.get_offers(search_params)

    result = JSON.parse(res.body).symbolize_keys

    if res.status == 200
      if fclient.check_response(res.body, res.headers['x-sponsorpay-response-signature'])
        @info = result[:information]
        page = search_params[:page] || 1
        @offers = WillPaginate::Collection.create(page, 15, result[:count]) do |pager|
          pager.replace result.try(:[], :offers) || []
        end
      else
        @error = 'Server sent an invalid response. Please try again.'
      end
    else
      if result[:code] == 'ERROR_INVALID_UID'
        @error = 'You must provide an user name.' if params[:commit]
      else
        @error = result[:message]
      end
    end
  end
end
