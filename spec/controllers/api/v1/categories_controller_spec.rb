require 'rails_helper'
require 'json'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'with proper session' do
      before do
        get :index, params: { page: '1', format: :json }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
