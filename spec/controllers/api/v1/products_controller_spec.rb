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
end
