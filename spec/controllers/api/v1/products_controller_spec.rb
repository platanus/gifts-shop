require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    context 'with proper session' do
      let(:receiver) { create(:receiver) }
      let(:giver) { receiver.giver }

      before do
        request.cookies['receiver_id'] = receiver.id
        request.cookies['giver_id'] = giver.id
        get :index, format: :json
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'without proper session' do
      before do
        get :index, format: :json
      end

      it 'redirects to landing page' do
        expect(response).to redirect_to landing_show_path
      end
    end
  end
end
