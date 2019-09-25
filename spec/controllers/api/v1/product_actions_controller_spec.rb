require 'rails_helper'

RSpec.describe Api::V1::ProductActionsController, type: :controller do
  describe 'POST #create' do
    let(:receiver) { create(:receiver) }
    let(:product) { create(:product) }
    let(:product_action_params) do
      { product_action: {
        product_id: product.id,
        action_type: 'display'
      } }
    end

    before do
      request.cookies['receiver_id'] = receiver.id
    end

    it 'returns http success' do
      post :create, params: product_action_params, as: :json
      expect(response).to have_http_status(:success)
    end
  end
end
