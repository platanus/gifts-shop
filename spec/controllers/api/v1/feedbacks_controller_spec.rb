require 'rails_helper'

RSpec.describe Api::V1::FeedbacksController, type: :controller do
  describe 'POST #create' do
    let(:fake_telegram_token) { '1234:5678' }
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
      ENV['BOT_TOKEN'] = fake_telegram_token
      ENV['TELEGRAM_GROUP_ID'] = '-1234'
      stub_request(:post, "https://api.telegram.org/bot#{fake_telegram_token}/sendMessage")
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
