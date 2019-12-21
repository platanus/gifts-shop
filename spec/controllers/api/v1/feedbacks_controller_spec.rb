require 'rails_helper'

RSpec.describe Api::V1::FeedbacksController, type: :controller do
  describe 'POST #create' do
    let(:receiver) { create(:receiver) }
    let(:giver) { receiver.giver }
    let(:gift_found_feedback_params) do
      { feedback: {
        fulfilled: true
      } }
    end
    let(:phone_number) { '+5691234567' }
    let(:email) { 'example_email@example.com' }
    let(:gift_not_found_feedback_params) do
      { feedback: {
        fulfilled: false,
        additional_info: 'This is additional information regarding my gift.',
        phone_number: phone_number,
        email: email
      } }
    end

    before do
      session['receiver_id'] = receiver.id
    end

    context 'when fulfilled' do
      it 'returns http success' do
        post :create, params: gift_found_feedback_params, as: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not fulfilled' do
      it 'returns http success' do
        post :create, params: gift_not_found_feedback_params, as: :json
        expect(response).to have_http_status(:success)
      end

      it 'updates the givers phone number' do
        post :create, params: gift_not_found_feedback_params, as: :json
        expect(giver.reload.phone_number).to eq(phone_number)
      end

      it 'updates the givers email' do
        post :create, params: gift_not_found_feedback_params, as: :json
        expect(giver.reload.email).to eq(email)
      end
    end
  end
end
