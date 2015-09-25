require 'rails_helper'

require 'fyber_client'

describe Fyber::Client do
  subject(:fyber) { Fyber::Client.new }

  context '.get_offers' do
    it 'without params' do
      resp = fyber.get_offers
      expect(resp.status).to be(400)
      expect(resp.body).to eq('{"code":"ERROR_INVALID_UID","message":"An invalid user id (uid) was given as a parameter in the request."}')
    end

    it 'without timestamp' do
      resp = fyber.get_offers(uid: 'user1')
      expect(resp.status).to be(400)
      expect(resp.body).to eq('{"code":"ERROR_INVALID_TIMESTAMP","message":"An invalid or expired timestamp was given as a parameter in the request."}')
    end

    it 'with timestamp' do
      resp = fyber.get_offers(uid: 'user1', timestamp: '1443114790')
      expect(resp.status).to be(200)
    end
  end
end
