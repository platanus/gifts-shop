require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    let(:receiver) { create(:receiver) }
    let(:giver) { receiver.giver }

    context 'with proper session' do
      before do
        session['receiver_id'] = receiver.id
        session['giver_id'] = giver.id
        get :index, params: { number_of_products: "5", format: :json }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'without giver_id' do
      before do
        session['receiver_id'] = receiver.id
        get :index, params: { number_of_products: "5", format: :json }
      end

      it 'redirects to landing page' do
        expect(response).to redirect_to landing_show_path
      end
    end

    context 'without receiver_id' do
      before do
        session['giver_id'] = giver.id
        get :index, params: { number_of_products: "5", format: :json }
      end

      it 'redirects to landing page' do
        expect(response).to redirect_to landing_show_path
      end
    end
  end
end
