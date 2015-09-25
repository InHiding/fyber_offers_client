class OfferController < ApplicationController
  def index
    search_params = { uid: 'player1', pub0: 'campaign2', timestamp: Time.current.to_i.to_s, page: 2 }

    fclient = Fyber::Client.new
    res = fclient.get_offers(search_params)

    result = JSON.parse(res.body).symbolize_keys

    if fclient.check_response(res.body, res.headers['x-sponsorpay-response-signature'])
      @info = result[:information]
      @offers = result.try(:[], :offers)
    else
      @error = 'Server sent an invalid response. Please try again.'
    end
  end
end
