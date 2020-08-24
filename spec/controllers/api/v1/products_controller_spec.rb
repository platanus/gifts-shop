require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #index" do
    context 'with proper session' do
      before do
        get :index, params: { number_of_products: "5", format: :json }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH #update" do
    let(:product) { create(:product) }
    let!(:promoted_value) { product.promoted }

    context 'with promoted toggle' do
      before do
        patch :update, params: { type: 'promoted', id: product.id, format: :json }
      end

      it 'changes product promoted attribute' do
        expect(response).to have_http_status(:success)
        expect(product.reload.promoted).not_to eq(promoted_value)
      end
    end
  end
end
