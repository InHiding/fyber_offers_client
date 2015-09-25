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
  end
end
