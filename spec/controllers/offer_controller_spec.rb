require 'rails_helper'

describe OfferController do
  context '.index' do
    context 'with empty query' do
      it 'responds with success' do
        get :index
        assert_response :success
      end

      it 'renders index view' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'with query params' do
      context 'without uid' do
        it 'return error message' do
          get :index, offer: { uid: '' }, commit: 'Find Offers'
          expect(assigns(:error)).to include('You must provide an user name.')
        end
      end

      context 'with uid' do
        it 'return offers' do
          get :index, offer: { uid: 'user1' }, commit: 'Find Offers'
          expect(assigns(:offers)).not_to be_nil
        end
      end

      context 'with invalid signature_key' do # body may have been changed by someone :0
        it 'return an error message' do
          allow_any_instance_of(Fyber::Client).to receive(:check_response).and_return(false)

          get :index, offer: { uid: 'user1' }, commit: 'Find Offers'
          expect(assigns(:error)).to include('Server sent an invalid response. Please try again.')
        end
      end
    end
  end
end
