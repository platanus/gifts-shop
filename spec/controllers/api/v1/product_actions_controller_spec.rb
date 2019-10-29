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
      session['receiver_id'] = receiver.id
    end

    it 'returns http success' do
      post :create, params: product_action_params, as: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy_like' do
    let(:receiver) { create(:receiver) }
    let!(:product_action) { create(:product_action, action_type: 'like', receiver: receiver) }

    before do
      session['receiver_id'] = receiver.id
    end

    context 'when product doesnt exists' do
      let(:product_action_params) do
        { product_action: { product_id: product_action.product_id + 1 } }
      end

      it 'doesnt destroy any action' do
        expect do
          delete :destroy_like, params: product_action_params, as: :json
        end.to change { ProductAction.count }.by(0)
      end
    end

    context 'when the product exists' do
      let!(:product_action_params) { { product_action: { product_id: product_action.product_id } } }

      it 'destroys the action' do
        expect do
          delete :destroy_like, params: product_action_params, as: :json
        end.to change { ProductAction.count }.by(-1)
      end
    end
  end
end
