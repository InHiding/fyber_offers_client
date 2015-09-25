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

  context '.check_response' do
    context 'with empty data' do
      it 'and valid signature' do
        expect(fyber.check_response('', Digest::SHA1.hexdigest(ENV['FYBER_API_KEY']))).to be_truthy
      end

      it 'and invalid signature' do
        expect(fyber.check_response('', Digest::SHA1.hexdigest(''))).to be_falsy
      end
    end

    context 'with data' do
      it 'and valid signature' do
        signature_key = Digest::SHA1.hexdigest("something#{ENV['FYBER_API_KEY']}")
        expect(fyber.check_response('something', signature_key)).to be_truthy
      end

      it 'and invalid signature' do
        signature_key = Digest::SHA1.hexdigest("this is wrong#{ENV['FYBER_API_KEY']}")
        expect(fyber.check_response('something', signature_key)).to be_falsy
      end
    end
  end
end
